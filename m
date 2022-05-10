Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9A52128A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbiEJKut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiEJKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:50:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A034B8B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:46:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t13so14312480pgn.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ywkCd0VQclbYtbuLcC/2MBQIqOITw9zVVBZNkCemTOo=;
        b=h0kkPCMH6mPJCfovcbuIStuogjg+GSSyZfKyGX6j68msx5w4YZi0zrfa/0Dshwr3GN
         7RQ1KxIeG1PXDsecsjvmgUcAmrozA5BpQNdXi0GekocXEFlkce+AZEZUg2hxd74t7Q6b
         Gio+Nbtf97oPkaBTUiVEboPYAb85Lj3wwgK1nuRGqbKHKIb7Q1DrfNyYOXBo7RhiuBXk
         BRJbvO0Ri7yOfaOl8eZugNE1EkGkOuWjEy+ngDm4a4V57QfGr3D6FPMoIVpEbsEY4LDc
         vPdwCEsRw6QssvT0owD6Vo+zMVVeU/EruhI3A9lq3SKarrhL+NRBQqOw8YqKP16UoKKY
         qcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ywkCd0VQclbYtbuLcC/2MBQIqOITw9zVVBZNkCemTOo=;
        b=i8jS1yZiDwaw98vGKQcNEh7qpa405zRS/wcxBKIdNJwuwcwfiw29EBn1H13Q2LO2Qf
         a41c1x+CkjXh6xiwbM/UN+VOY/595opZBzoEE4uz2g/VUVDALjt5hK1B3StA2Nk4clri
         Z4CQn153xZV6CmXR/+sZ95DommBXomCVVsuyM6I/asjMggPAGhJc9DZddyHt5eJJxQ7R
         gxNfUQjG350QxRBeX5Ki6OlblooYAJ+qGQkb/ejxq8033g8yrLAudolweKF41DSlk2Jw
         lKZwlfVGAph1YLQ70Zhq46JCNUeKYeC956oyA7OwTMjmi3pfeMLKRni4AjwDYVcbel0h
         cXpw==
X-Gm-Message-State: AOAM530RvNHGaiyeLY9d/Kvj6e5WHMC6S5Yl2WHM+qTO7DtX8s8qfAeX
        YsM1shVy9lMOU3LkRK7C5pc=
X-Google-Smtp-Source: ABdhPJzMrukhfzR4yG2wWMevWm9IkJ0FdxD4csfom41LNkkZtiJ1+e5zsn4K6SEBEKiso2xXU+F2/Q==
X-Received: by 2002:a63:cd41:0:b0:3c5:1242:3a0d with SMTP id a1-20020a63cd41000000b003c512423a0dmr16424233pgj.266.1652179607275;
        Tue, 10 May 2022 03:46:47 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b0015e8d4eb1ecsm1791916pls.54.2022.05.10.03.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:46:46 -0700 (PDT)
Date:   Tue, 10 May 2022 20:46:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 24/29] watchdog/hardlockup: Use parse_option_str() to
 handle "nmi_watchdog"
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
        <20220506000008.30892-25-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-25-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652179333.fnu2fjiffn.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> Prepare hardlockup_panic_setup() to handle a comma-separated list of
> options. Thus, it can continue parsing its own command-line options while
> ignoring parameters that are relevant only to specific implementations of
> the hardlockup detector. Such implementations may use an early_param to
> parse their own options.

It can't really handle comma separated list though, until the next
patch. nmi_watchdog=3Dpanic,0 does not make sense, so you lost error
handling of that.

And is it kosher to double handle options like this? I'm sure it
happens but it's ugly.

Would you consider just add a new option for x86 and avoid changing
this? Less code and patches.

Thanks,
Nick

>=20
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Corrected typo in commit message. (Tony)
>=20
> Changes since v4:
>  * None
>=20
> Changes since v3:
>  * None
>=20
> Changes since v2:
>  * Introduced this patch.
>=20
> Changes since v1:
>  * None
> ---
>  kernel/watchdog.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 9166220457bc..6443841a755f 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -73,13 +73,13 @@ void __init hardlockup_detector_disable(void)
> =20
>  static int __init hardlockup_panic_setup(char *str)
>  {
> -	if (!strncmp(str, "panic", 5))
> +	if (parse_option_str(str, "panic"))
>  		hardlockup_panic =3D 1;
> -	else if (!strncmp(str, "nopanic", 7))
> +	else if (parse_option_str(str, "nopanic"))
>  		hardlockup_panic =3D 0;
> -	else if (!strncmp(str, "0", 1))
> +	else if (parse_option_str(str, "0"))
>  		nmi_watchdog_user_enabled =3D 0;
> -	else if (!strncmp(str, "1", 1))
> +	else if (parse_option_str(str, "1"))
>  		nmi_watchdog_user_enabled =3D 1;
>  	return 1;
>  }
> --=20
> 2.17.1
>=20
>=20
