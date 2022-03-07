Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3007D4CF316
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiCGIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiCGIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:00:36 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED61BE84
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:59:41 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2dbd97f9bfcso153805927b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 23:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2n3Gy8PCy3LVN2XNSdMRoacv8eUJ8xB+sxi9bVZyD3c=;
        b=5OWrtiVgMasjIZB1DmCFAX1S1T45oNWXdQrVdiMs29UztnAt7nYNqVHADtm7O8hkK0
         /4XJv7/XZPc5kiUaPjXVpzcyUpkXR1kJLzhoVb6ZMD3UFNxPgDvd8XEj7FGlvdfV85uR
         0KXvmR3nEnthhg2uM2u32l4AOOaA74kjx/mHRs/2X7+JHB3H9c6BXGB5+/LUHnfa9hay
         hUaXeUzZstYyUBn0VELBrmFPigPSMqCzRedRj0OUektZuyjK+DOUsYmy0o2t+75a8fGA
         GfLGnl5/7m69kDd5yOty0tKybSTfHQQ1HjCo9AMK2bJ6i059apKwO9dReA8Sso38vBSr
         cOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2n3Gy8PCy3LVN2XNSdMRoacv8eUJ8xB+sxi9bVZyD3c=;
        b=mAiUMwGgkjZydlMS8uHHuujw8ZVUt4Vut+qEQ7LJ8KnmUhGwCp7SNRm8OXFTgi/VQS
         VsDjDqBLUKNVLs+i9nXANe5YgpIufRNKlf9orX0+0ICPAV/1IHLnpx55qciBDkM3rbGL
         Al/yBODNhbY/L+vOP0ItAftdwA1cTxPsKjMPmJlmWclsfDnKW6rRFVz8j/FjDkSOUjQp
         9ks3Y9Xd6BlFX9sjDe3bDqp0k7PKqf06PnXI3ZzqCi+lho1rA5L+a5T2bn3E8WiAxO93
         xJ3Ggu0GWh3BlGZ27LTM3HfoN/n9vx+EMYoQVln1A1M5TkFYZX83srdVSTH+aH/hOwix
         NRbg==
X-Gm-Message-State: AOAM531xH6kW/EUlrygK83SsYMHKmV9dHTmS4ru2DG7dC0Ce7XwNycn8
        CtfKeEIazGqaQXXmEF5cy7O2KeEBCH6en0xoOfP+jg==
X-Google-Smtp-Source: ABdhPJzhoNTX5i7IouFroqKtV/BCzTBH6JXfSFNhm/Vw/PaiAp0tJFcZhOeVaTBtJjgRiCcxNRiHCxS17mXyK1jwHS8=
X-Received: by 2002:a81:6c57:0:b0:2dc:53af:c24 with SMTP id
 h84-20020a816c57000000b002dc53af0c24mr7864581ywc.499.1646639980308; Sun, 06
 Mar 2022 23:59:40 -0800 (PST)
MIME-Version: 1.0
References: <YgOQBNIdf0UnSH+M@Red> <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red> <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red> <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
In-Reply-To: <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 7 Mar 2022 09:59:29 +0200
Message-ID: <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 11:49 PM Herbert Xu <herbert@gondor.apana.org.au> wr=
ote:
>
> On Fri, Mar 04, 2022 at 02:30:06PM +0100, Corentin Labbe wrote:
> >
> > Hello
> >
> > I got:
> > [   17.563793] ------------[ cut here ]------------
> > [   17.568492] DMA-API: ccree e6601000.crypto: device driver frees DMA =
memory with different direction [device address=3D0x0000000078fe5800] [size=
=3D8 bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTIONAL]
>
> The direction argument during unmap must match whatever direction
> you used during the original map call.


Yes, of course. I changed one but forgot the other.

Corentin, could you be kind and check that this solves the original
problem and does not produce new warnings?

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
b/drivers/crypto/ccree/cc_buffer_mgr.c
index 11e0278c8631..31cfe014922e 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -356,12 +356,14 @@ void cc_unmap_cipher_request(struct device *dev,
void *ctx,
                              req_ctx->mlli_params.mlli_dma_addr);
        }

-       dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
-       dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src));
-
        if (src !=3D dst) {
-               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_BIDIRECTIONA=
L);
+               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_TO_DEVICE);
+               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_FROM_DEVICE)=
;
                dev_dbg(dev, "Unmapped req->dst=3D%pK\n", sg_virt(dst));
+               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src));
+       } else {
+               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL=
);
+               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src));
        }
 }

@@ -377,6 +379,7 @@ int cc_map_cipher_request(struct cc_drvdata
*drvdata, void *ctx,
        u32 dummy =3D 0;
        int rc =3D 0;
        u32 mapped_nents =3D 0;
+       int src_direction =3D (src !=3D dst ? DMA_TO_DEVICE : DMA_BIDIRECTI=
ONAL);

        req_ctx->dma_buf_type =3D CC_DMA_BUF_DLLI;
        mlli_params->curr_pool =3D NULL;
@@ -399,7 +402,7 @@ int cc_map_cipher_request(struct cc_drvdata
*drvdata, void *ctx,
        }

        /* Map the src SGL */
-       rc =3D cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx->in_=
nents,
+       rc =3D cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->in_nent=
s,
                       LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_nents);
        if (rc)
                goto cipher_exit;
@@ -416,7 +419,7 @@ int cc_map_cipher_request(struct cc_drvdata
*drvdata, void *ctx,
                }
        } else {
                /* Map the dst sg */
-               rc =3D cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
+               rc =3D cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
                               &req_ctx->out_nents, LLI_MAX_NUM_OF_DATA_ENT=
RIES,
                               &dummy, &mapped_nents);
                if (rc)


>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
