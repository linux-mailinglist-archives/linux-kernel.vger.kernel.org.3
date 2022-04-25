Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8F50E840
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiDYScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244280AbiDYScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:32:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D11C934;
        Mon, 25 Apr 2022 11:29:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w16so10041738ejb.13;
        Mon, 25 Apr 2022 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnGqac5cphPPsi4AaO7yleP8x5MKmYW3cYfiBMddgYY=;
        b=R6ssH73p6eSp/7J85Re0lJY2ynrIY41nEURYuXkx75RXn+j17ioAZ/UeNGD4Cdk/rB
         VOWVBJdMReO623a+2NkqP8SJrDLmKMdxj9aDUz+aN5HQSSU2mBV/NoD8uXIpE3N3hJ8K
         a/aZtBGnMJtyoVltYqihHwkoC4Ikv6TpZzCL3Gh6hAzuhrzAiAnmHqN/4HlyX0RNR5cy
         pXYg64B3mX2SKNm5/1SKPJCNnOgkGXk7+xNnQfPOu1JD6e6yCRfZ8IOROkhQHKPFZ5iL
         SJz/8jWbFKFwNyV/4qyHv06/UBn9hhkTDubgVgX8Hl+rMlEClYfHytzuEaPUqsXssLr0
         nijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnGqac5cphPPsi4AaO7yleP8x5MKmYW3cYfiBMddgYY=;
        b=uZzsA2BsbOWH6fvvwkf15Q2kCCevR21SqX+azpw3FhyyMJv2sLZRnqESRA5SFse8ca
         35pWJ7wBCoqbeSBCIpJPnBBD/Fg9vtp7GmBprb8c+x696WD6ww/jhchvrf5xO/nR828Z
         a2xuDsl89g4Ry871BaI5yg9Pv3MGQRIsL1LkzglZNt4NUnatu1gwZ2SA+YDePSlfSslb
         6NkSNOwPKba+Gvc41YY4QUpjDuyIYcW+GASWBRtIQywLjgOOgEZvrTgqFQzWe255jCTf
         lLFzQzoSzOLRErpjDjc4IJTrrrssTk3I5ZJxObtOm4o9O7QYJaavcVbkPI8ciBaM5flB
         C3HA==
X-Gm-Message-State: AOAM5316DkpW9Ao+5UPSpbcz6E4pFGWQKGbN7Myy37i42ETVsQuRfRy2
        rxp1MH1abibPIn5QmXeVPeo=
X-Google-Smtp-Source: ABdhPJyxKYOtD1tDbGljJy2g+SFIK6ZxkIi3uWh1VZe8ukKU5XkDM9/cASplidcAlVSpbjPBnElzlw==
X-Received: by 2002:a17:907:8b13:b0:6f3:9216:b73e with SMTP id sz19-20020a1709078b1300b006f39216b73emr7129028ejc.188.1650911346630;
        Mon, 25 Apr 2022 11:29:06 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709064f9200b006e7f229b332sm3832867eju.36.2022.04.25.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:29:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
Date:   Mon, 25 Apr 2022 20:29:03 +0200
Message-ID: <2181693.iZASKD2KPV@leap>
In-Reply-To: <20220413225531.9425-1-fmdefrancesco@gmail.com>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 14 aprile 2022 00:55:31 CEST Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. The same is true for kmap_atomic().
>=20
> In file pci/hmm/hmm.c, function hmm_store() test if we are in atomic
> context and, if so, it calls kmap_atomic(), if not, it calls kmap().
>=20
> First of all, in_atomic() shouldn't be used in drivers. This macro
> cannot always detect atomic context; in particular, it cannot know
> about held spinlocks in non-preemptible kernels.
>=20
> Notwithstanding what it is said above, this code doesn't need to care
> whether or not it is executing in atomic context. It can simply use
> kmap_local_page() / kunmap_local() that can instead do the mapping /
> unmapping regardless of the context.
>=20
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Therefore, hmm_store()() is a function where the use
> of kmap_local_page() in place of both kmap() and kmap_atomic() is
> correctly suited.
>=20
> Convert the calls of kmap() / kunmap() and kmap_atomic() /
> kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> unnecessary tests which test if the code is in atomic context.
>=20
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/media/atomisp/pci/hmm/hmm.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Hi Mauro,

I'm writing for just a gentle ping for this and two other staging/atomisp/=
=20
patches that still seem to be waiting to be applied.

In the meantime I would like to remind you that Hans de Goede has=20
successfully tested this patch and the other two on both the front and back=
=20
cams of a chuwi hi8 tablet.

Please let me know if there is anything else that is required to be done in=
=20
order to accept the three patches.

Thanks,

=46abio M. De Francesco


