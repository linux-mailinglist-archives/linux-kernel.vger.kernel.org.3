Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364F74E1948
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 01:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiCTA7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 20:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbiCTA7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 20:59:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73FB39A;
        Sat, 19 Mar 2022 17:57:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id p15so23618637ejc.7;
        Sat, 19 Mar 2022 17:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xL/91CQtbh1UaVmRRlTOuCwEzQk4/A5pjF+O731hxm0=;
        b=Qw+T8qYqtAMZFMtvf6EQMOYWgdpC1mkns6edWSTqkwnAmzTTqLeXxzRXflHiz9zoiD
         i2wB4E1/NDY7Nbv4wg/6cJKZ7LsY3ez6AqOIhnPSB7Z3vI/DN6ovK8DUhAGqC/HNr39M
         EgMKfIxB+U/vf+pfPXMTnOoXDvpivcbaqBlLJv/8PPGteDWer9bVnajvrd8C9rnHXQJt
         Y6HLLd6hT42gy03/2kVFDF62Dst6Rn4SOpJD76ucqmhkqR3dfHCiRVWixkxu1komnAYi
         9EtQiiHQeS/q+y9ySvmH+kcw4ESxOvYOLkgjHqnKeRTow6KNZa8HJNmeSGL9c5j7UJ2B
         wQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xL/91CQtbh1UaVmRRlTOuCwEzQk4/A5pjF+O731hxm0=;
        b=KyJoePzzhOFdeiwXRvVFUBsgiianeRSDrVSb8pog7vxx01qE2vCum9gp1SAI30BYpg
         eeoGhY88r2WNSl5vqSiAlC48u8UtkIrAbB3J0leIL0qNtbZV/Jr4Ojyi7j7T5womvTN7
         Z0814IiiVPIt4c8GIVMx4qrIUI+wUMnDfkzlQUKfDTABAQv9bdzLX00SMoJpAyBqqeQJ
         1G20EjQhfNLLVaBItdKv1t0yu8lxWbZfpMA9ro620X/2XEIO4xABP8IWOi+mt1yjkg3s
         h5SRu5OZ6LW31pUkAIhv0ZmKI1Fmt35txXxo+Gom+bRRt01llaptZX9gKjS21eqbw7OU
         j/bQ==
X-Gm-Message-State: AOAM532KOsl6gra8Q/hnZT011WUAwfxEJ8Iz57t3OGwLpHkrMJqOkvBk
        5x0Nq3N2s4yqneCbZED1izdQeiR537OcYg==
X-Google-Smtp-Source: ABdhPJywklwE7dbcujRJey+W8XQRuTdyG1Cv/cP6Dk++ogP4ccJuwejJaAqdyfxRGsDFhJ2a6fkyyw==
X-Received: by 2002:a17:906:9743:b0:6d8:632a:a42d with SMTP id o3-20020a170906974300b006d8632aa42dmr15233303ejy.157.1647737860494;
        Sat, 19 Mar 2022 17:57:40 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm6088997edt.22.2022.03.19.17.57.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Mar 2022 17:57:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] ufs: remove an unneed NULL check on list iterator
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220319042657.21835-1-xiam0nd.tong@gmail.com>
Date:   Sun, 20 Mar 2022 01:57:39 +0100
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        Alim Akhtar <alim.akhtar@samsung.com>, avri.altman@wdc.com,
        daejun7.park@samsung.com, bvanassche@acm.org, beanhuo@micron.com,
        keosung.park@samsung.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EEE0ACC-6F7F-4D29-AA2B-751E4677B35E@gmail.com>
References: <20220319042657.21835-1-xiam0nd.tong@gmail.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19. Mar 2022, at 05:26, Xiaomeng Tong <xiam0nd.tong@gmail.com> =
wrote:
>=20
> The list iterator is always non-NULL so it doesn't need to be checked.
> Thus just remove the unnecessary NULL check.
>=20
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
> drivers/scsi/ufs/ufshpb.c | 6 ------
> 1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
> index 2d36a0715..a3db0ad60 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -869,12 +869,6 @@ static struct ufshpb_region =
*ufshpb_victim_lru_info(struct ufshpb_lu *hpb)
> 	struct ufshpb_region *rgn, *victim_rgn =3D NULL;
>=20
> 	list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn) {
> -		if (!rgn) {
> -			dev_err(&hpb->sdev_ufs_lu->sdev_dev,
> -				"%s: no region allocated\n",
> -				__func__);
> -			return NULL;
> -		}

Maybe it make more sense to move that check after the loop body instead
of removing it completely? This code obviously does nothing in it's =
current
state but it's clear what the original intention was, so restoring that =
would
perhaps be better.

But probably someone with more experience about this code can make the =
call

> 		if (ufshpb_check_srgns_issue_state(hpb, rgn))
> 			continue;
>=20
> --=20
> 2.17.1
>=20

	Jakob

