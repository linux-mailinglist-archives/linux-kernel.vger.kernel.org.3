Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544C554CBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352852AbiFOOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349219AbiFOOqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:46:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC57F3B3D3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655304367;
        bh=fO4VIThT2jN8IjrFoYjpk6jSRHO/M4kILno2rNLiA9s=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
         References;
        b=LBoX6PPlqH0U18Mip7KIjDPw/rYe0b5zpMbCLpk5xJl/4yq96+tuwPFHye8hKzq8w
         xNh5Uhh4/PPfvwA5EtY2oENzYnKgshRDs6vmeBx5zJd2qFitHzNfD0/zcjNDC5VaRB
         ZrugLb/qe1c2R1jPmGuQRRxHTEqQE6zdl9PfYxwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [127.0.0.1] ([217.61.154.5]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1o4VcZ35bh-00825p; Wed, 15
 Jun 2022 16:46:06 +0200
Date:   Wed, 15 Jun 2022 16:46:03 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
CC:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: helping with remapping vmem for dma
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20220615131700.GA18061@lst.de>
References: <trinity-685a668a-2395-45f2-81e5-53f526863a66-1655295061671@3c-app-gmx-bap28> <6e58b50c-cd05-a37b-07e1-10ee24fb972f@arm.com> <20220615131700.GA18061@lst.de>
Message-ID: <C81BFF40-13C9-4C7E-BE98-0DAE9221E324@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ymi/dNLhID0rFfwSQkIthc5hPryrUBWKoviU/G5LfbZ5hPjWsd8
 RBpykFdP3h0tarGpyZzwg4wXqniI7BpoFqquQLQ/Ce/upW6B44LBGnsD0qaENx9jGlnxPbD
 Ha3g4WzaKMvFvy5NsbcGMPqcWmGqrwoEQdVS/0k9CR0n34CC59yC1JIdW5Te9FhYl7i3gc9
 FRVV++YKgk+rotP7WXFiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E+HnZb1mwbA=:om6cIiNQNYQg16D7bxOOzI
 VB6RwzUENSUhzyLEDKjpUhL/LmxkOF52F77csv/+3tPBsUPLdp4oyMQYVIHfbk/qRjcbF2nro
 +UsaGAKdZgKHGE45sSVdmG/E17Z6Kb7eeAft/ex7uzyK5b3VkH1hWS+xPMqCeaqtRI/fLJwy2
 3WjyGvzIYqMedFEAOtmWIv4PQ83+XGuADRKBvwl2BrEBzMguRsPfNsQnrpfdU1LAganeumFmn
 pYVU4KRkOhlLebuxmdS+j/QmJx/LTvm5QvnYVo0uiuqnjGnDNsbCKLMKhvBYtCmFsfv9x6bPm
 fZAmDi+8SgQYrsonMnhjXki8jKZsR+DsRBduL/tYMWjliJtKgjmFK8oCEygdDVd64HhNbZ6Wf
 YiBRMZveXMm5ie8GdAIlMcadA7esnl1sbwHXXGZC1xXtngS4TMqb47Iiik76fK12MX2YN5pJp
 j0otJfcA5gJeAkfXd9U+zGyErzjvMp1zuj/qN5GSfVY8ZGEcAaXp9TmOf+drr3GBH/NC4KaSD
 WI4aY+PWfxzDcabOSv5tsAW17fsGHbpI4CTcOAb3ZK/OxbFqwbHnUhojIQ1fpyYeNrVPezQdj
 H6KrUrSKJniv62sM/mah8dM+nDZ4hKKG5x08wSGZD1Tj1hYHbR9S0zGoDlVwsWZJMZ+qKedSJ
 imqXDofzpLeZMDjz0x6T4zfBI6+3F9suCHzhy6+vCUib7z2MS1xJe7VY/ac4Rn00H4z9nm1IG
 54jYCoteDtHYO+WgXsioXJg6U1M/yA5lRygr2URUKOBfQ+ObwpzB9epimgxtKjA2awuNx9r+j
 k6vKQOCZHdLH/bKRIa4iuKHEblh6vD8ptMe4tbxugnrS6EMzzDU3Q58Zypkn5TUL+e7EN4EDh
 Trl8TTqFE56O9SQXHvEsEBS6w8j5YZ7w0cxczLILC/zEgJYpDlk8VJW7FBjhQOMl9nFwrck2S
 PV2TvcM3yeWxsuP3x52iO6pqMIUVJS69wa4zRL2Z7jseXl8IJWxq3u1r4Ke14MfftSdRHafij
 ycdgsPadLdvLAX+w0ckZcCuJA/kaUp+BN9Hx+EO+sg6JcBY+T0tjvUHDjVpFuqoc31DnmtGHy
 XAlJgfKP8rVPvHEsmrpGCNZ6ST5WD7sf7Ty42Yz9B/FtuGzT6qjKAXI2A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15=2E Juni 2022 15:17:00 MESZ schrieb Christoph Hellwig <hch@lst=2Ede>:
>On Wed, Jun 15, 2022 at 02:15:33PM +0100, Robin Murphy wrote:
>> Put simply, if you want to call dma_map_single() on a buffer, then that=
=20
>> buffer needs to be allocated with kmalloc() (or technically alloc_pages=
(),=20
>> but then dma_map_page() would make more sense when dealing with entire=
=20
>> pages=2E
>
>Yes=2E  It sounds like the memory here comes from the dma coherent
>allocator, in which case the code need to use the address returned
>by that and not create another mapping=2E

As i have not found position where memory is allocated (this is a very hug=
e and dirty driver) is it maybe possible to check if buf is such "allready =
dma" memory (maybe is_vmalloc_addr) and call dma_single_map only if not (us=
ing original buf if yes)?

But i guess it should map only a part of available (pre-allocated) memory =
and other parts of this are used somewhere else=2E So i can ran into some i=
ssues caused by sharing this full block in different functions=2E
Hi,

Thanks for first suggestions=2E=20
regards Frank
