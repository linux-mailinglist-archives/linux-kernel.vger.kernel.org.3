Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA355CE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiF1G0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiF1G0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C05DE64;
        Mon, 27 Jun 2022 23:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2219B618E3;
        Tue, 28 Jun 2022 06:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F12C3411D;
        Tue, 28 Jun 2022 06:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656397569;
        bh=FCX0XRo3D49ZdUr67eJ3VvX3ZKDk1wg0jbSa/sjSNQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvKwFwJaIQ2IjbJQGbPKLnQ74ig/BYaLYrkxpPVy9K0iCkrNniImj0bVS3I/CTSwm
         JB4tHyF5rXSWj2MNbhvooqwdmrM1cvpQ12f8YqeANgXZdjfLkjnbSI2pm468pCTRWf
         lYJpCFJdTgw7y+qdvY0GzGMJ3leRmGB5uALvcJAc=
Date:   Tue, 28 Jun 2022 08:26:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v12 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <Yrqe/3Mpnmw4sfyx@kroah.com>
References: <20220628044843.2257885-1-xji@analogixsemi.com>
 <20220628044843.2257885-3-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628044843.2257885-3-xji@analogixsemi.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:48:42PM +0800, Xin Ji wrote:
> +static int anx7411_process_cmd(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	struct fw_msg *msg = &ctx->recv_msg;
> +	u8 len;
> +	u8 crc;
> +	int ret;
> +
> +	/* Read message from firmware */
> +	ret = anx7411_reg_block_read(ctx->spi_client, CMD_RECV_BUF,
> +				     MSG_LEN, (u8 *)msg);
> +	if (ret < 0)
> +		return 0;
> +
> +	if (!msg->msg_len)
> +		return 0;
> +
> +	anx7411_reg_write(ctx->spi_client, CMD_RECV_BUF, 0);

Again, you are not checking the return value here.  What happens if this
failed?

> +
> +	len = msg->msg_len & MSG_LEN_MASK;
> +	crc = checksum(dev, (u8 *)msg, len + HEADER_LEN);
> +	if (crc) {
> +		dev_err(dev, "message error crc(0x%.02x)\n", crc);
> +		return -ERANGE;
> +	}
> +
> +	return anx7411_parse_cmd(ctx, msg->msg_type, msg->buf, len - 1);
> +}
> +
> +static void anx7411_translate_payload(struct device *dev, __le32 *payload,
> +				      u32 *pdo, int nr, const char *type)
> +{
> +	int i;
> +
> +	if (nr > PDO_MAX_OBJECTS) {
> +		dev_err(dev, "nr(%d) exceed PDO_MAX_OBJECTS(%d)\n",
> +			nr, PDO_MAX_OBJECTS);
> +
> +		return;
> +	}
> +
> +	for (i = 0; i < nr; i++)
> +		payload[i] = cpu_to_le32(pdo[i]);
> +}
> +
> +static void anx7411_config(struct anx7411_data *ctx)
> +{
> +	struct device *dev = &ctx->spi_client->dev;
> +	struct typec_params *typecp = &ctx->typec;
> +	__le32 payload[PDO_MAX_OBJECTS];
> +
> +	/* Config PD FW work under PD 2.0 */
> +	anx7411_reg_write(ctx->spi_client, PD_REV_INIT, PD_REV20);
> +	anx7411_reg_write(ctx->tcpc_client, FW_CTRL_0,
> +			  UNSTRUCT_VDM_EN | DELAY_200MS |
> +			  VSAFE1 | FRS_EN);
> +	anx7411_reg_write(ctx->spi_client, FW_CTRL_1,
> +			  AUTO_PD_EN | FORCE_SEND_RDO);

Same with all of these, what happens if this fails?

thanks,

greg k-h
