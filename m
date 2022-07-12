Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF057169D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiGLKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiGLKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:08:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CBFAB6A5;
        Tue, 12 Jul 2022 03:08:30 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N95Rn-1nWubb3jkt-016BfD; Tue, 12 Jul 2022 12:08:29 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31cf1adbf92so75818957b3.4;
        Tue, 12 Jul 2022 03:08:28 -0700 (PDT)
X-Gm-Message-State: AJIora9+AI63I3LjNh7KOVK/ZJk/GkVX8OLiQHJ85sJek45pCnLlxBEx
        rgwm6yipqrSCLBX79OASXUHEDLaNibLkF/s4tc4=
X-Google-Smtp-Source: AGRyM1ui9OD5Yq2i+fMABdKkpuy4vEqlHosTHEJwDtBO6zr/PICh/tVPzUKIAjwAJEvX5GVRaRGjEc5xOSy7/jhlaqc=
X-Received: by 2002:a81:1914:0:b0:31c:e12a:f33a with SMTP id
 20-20020a811914000000b0031ce12af33amr24610715ywz.209.1657620507572; Tue, 12
 Jul 2022 03:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com> <181f1d88b64.e2eb2601586551.453778983551010212@linux.beauty>
In-Reply-To: <181f1d88b64.e2eb2601586551.453778983551010212@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Jul 2022 12:08:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3gX-JMh6E2X3rH+U37zhkA6b0+AJDtXCJfdZiMocxLjg@mail.gmail.com>
Message-ID: <CAK8P3a3gX-JMh6E2X3rH+U37zhkA6b0+AJDtXCJfdZiMocxLjg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
To:     Li Chen <me@linux.beauty>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Pnojn1jCOJfUaOK/YyrDsJCc2p4gM9GmSs9xBtBbrAKJfsYznNF
 DrvfNt9PKvSA9vZCtHG20w1N7bLQV01zQdNEYmr6a0WO8/adPZtUlmx+WBgyWBdkVxczuAD
 13xvlxQUfyssiiOXH4KgqwjYAGwyGmXXWWy8rDPPaGaOyfYAwVaSUaiaOK0r8ed724uqhhT
 Os0jG00RotVlGVAhL2fiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nbUa4DFy3kc=:2M8dSRt9xoxJ5LTzynVMzU
 gDj1R7IM0E3AA8ub/eJpmAoi9uKOBfb3kSgGp2TBaTUDkyEY0CFCq5azAmLztgy2HU+2n3vx7
 XZlsxFiEAZL91dNtpcWZze0Zkgowd7PFFKf5UAag8Aj2uc1xlHnixdKlHx7oJdrCLUy7Wfv7W
 sIV1xsVzi98HXsG6NsgJcZjf5wzsmQcSL1FxxsRNl3C/jEpmDw4KBDSd0EqJ50Jlw/1cyQOHX
 XqHYdtg6BJ2aNoBBdqKE8pz2jsoKWtBdcLIweQk+wNYr6FmWKbPmcIXbWPBeeKIoAFJAk9S26
 bvMa+ntaMhutUoqTpiVA0SFkkamfu62sg7nDKL/XS/zRueHJvFi11sSGLIWcGRZp5eCfPBD2d
 CeWsgnznUBp30bwww/+PV9aeJd1XSGD8i51MxqRM1tkcjF/lih2/oD1PmCLAf1Alz7jh2Vr1n
 lCuF+Bv+kdkbZ9W5aTFoSxYIVWlRt/ZfMnq/A2lBiODFSKtMsMBhheZ8QXWUK1PSf2zUOpZrd
 CevwmKU5HYczhjoZmrycRh/WdpMVg8KcFhnGPLSrKdY1siASTu4Br94o+H4ykkZRZqJTXldUv
 SRuRhcpdImygwXJ1Vj5AH1NAdfiOUS24+QMbAimdu3cU5/Ray0vjRMvLzxz5L5bB0kb5RG/VN
 LnMYUaXyN7prw0AB3ASw+HU4it36F7TxUuTb5/sI7wbfinFwmypy/89h/bqDhdVg286zWCrLO
 uU+53NynfW8U01hyngURKIDqWSu6PN2ZbQQAbSSjGovPx2ZOIACRYqILs3dcbZPLoBYcI8i7J
 s7pVk1IHjcpHe4wQKCe8QP1QxDK3nNJfytQlsFkrPDdfwrdxgXWy/Fh59p0mW77ARF0IYRVdZ
 Q3ZWIydaWZzkbk36iBJyrsSXxlFw3bv0ViShZFdxM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:58 AM Li Chen <me@linux.beauty> wrote:
>  > On Tue, Jul 12, 2022 at 2:26 AM Li Chen <me@linux.beauty> wrote:
>  > >  ---- On Mon, 11 Jul 2022 21:28:10 +0800  Arnd Bergmann <arnd@arndb.de> wrote ---
>  > >  > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
>  > >  > The problem here is that the DT is meant to describe the platform in an OS
>  > >  > independent way, so having a binding that just corresponds to a user space
>  > >  > interface is not a good abstraction.
>  > >
>  > > Gotcha, but IMO dts + rmem is the only choice for our use case. In our real
>  > > case, we use reg instead of size to specify the physical address, so
>  > > memremap cannot be used.
>  >
>  > Does your hardware require a fixed address for the buffer? If it can be
>  > anywhere in memory (or at least within a certain range) but just has to
>  > be physically contiguous, the normal way would be to use a CMA area
>  > to allocate from, which gives you 'struct page' backed pages.
>
> The limitation is our DSP can only access 32bit memory, but total dram is > 4G, so I cannot use
> "size = <...>" in our real case (it might get memory above 4G). I'm not sure if other vendors' DSP also has
> this limitation, if so, how do they deal with it if throughput matters.

This is a common limitation that gets handled automatically by setting
the dma_mask of the device through the dma-ranges property in DT.
When the driver does dma_alloc_coherent() or similar to gets its buffer,
it will then allocate pages below this boundary.

If you need a large contiguous memory area, then using CMA allows
you to specify a region of memory that is kept reserved for DMA
allocations, so a call to dma_alloc_coherent() on your device will
get contiguous pages from that area, and move other data in those
pages elsewhere if necessary. non-movable data is allocated from
pages outside of the CMA reserved area in this case.

          Arnd
