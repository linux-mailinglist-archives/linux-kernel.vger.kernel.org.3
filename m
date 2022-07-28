Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA8583FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiG1NMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiG1NMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:12:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2232BD3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:12:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4F0F12223A;
        Thu, 28 Jul 2022 15:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1659013930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+AM9Ba+r0a5Evo71nndoB7O7xd8smBijytRfC8ILpJU=;
        b=dVhtB81cBL1x5UE2KhrE4NpC71/op+Y/56XkmATxClbo2yLLQD565meQ3DwMkXc5uCMI8O
        /iinNdftYB70nUEbv4jIG3608GQozd5KNeh4qgrtVXbk6rYb+2CXer6rg3nxbaZRy2+83V
        PjdsAS6kh9B8+UPJn+usOrE88Jle6qA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Jul 2022 15:12:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, quic_c_sbhanu@quicinc.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: introduce SNOR_ID3()
In-Reply-To: <41e6b74d-6973-60da-1556-82a1e879ffd4@microchip.com>
References: <20220510140232.3519184-1-michael@walle.cc>
 <20220510140232.3519184-2-michael@walle.cc>
 <160ddac1-6d0a-c922-1380-09e7823a285e@microchip.com>
 <41e6b74d-6973-60da-1556-82a1e879ffd4@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ff6ffb3f8e77b29b44883d30c9b4385e@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +#define SNOR_ID3(_jedec_id)
> 
> How about SFDP_ID3 and SFDP_ID6 instead?

Yes, probably a better name. I was also thinking about splitting
the id in vendor, device and additional bytes. But I haven't
thought of the actual implementation that much. Such as:

#define SFDP_ID(<u8 vid>, <u16 did>, <variable aux bytes>)
#define SFDP_ID_FULL(<num_continuation_code>, <u8 vid>, <u16 did>, 
<variable aux bytes>)

Couldn't make up a better name than that _FULL for now. Happy to hear
suggestions :)

-michael
