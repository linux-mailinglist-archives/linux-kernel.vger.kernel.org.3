Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58606575645
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiGNUUO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jul 2022 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiGNUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:20:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369CC65D67
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:20:11 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1Hi8-1oEp8a0m9S-002rRb for <linux-kernel@vger.kernel.org>; Thu, 14 Jul
 2022 22:20:10 +0200
Received: by mail-yb1-f171.google.com with SMTP id c131so4439087ybf.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:20:10 -0700 (PDT)
X-Gm-Message-State: AJIora+/zE0v2y//pBsN5qTO9jQVefysGKGijjm8scVc5fPo/jcugBt3
        49DnDqltcfhyd6hANwgA29638axqRqSgr5UF2Gw=
X-Google-Smtp-Source: AGRyM1vK2Fhiz79Qp41hMSFdiIQRmrvsSnSmKsaLltcEYMsk9uJoZ0tN0a5iGqPlh4rIEpo740a4oNfwBiEepInq0yk=
X-Received: by 2002:a25:7c41:0:b0:66d:766a:4815 with SMTP id
 x62-20020a257c41000000b0066d766a4815mr10491242ybc.480.1657830009057; Thu, 14
 Jul 2022 13:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220714185700.6137-1-pali@kernel.org>
In-Reply-To: <20220714185700.6137-1-pali@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 22:19:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a25JH4=XdS_QRBdTpLhsLyc13XYjt9xq8FcXCNUf+DTiQ@mail.gmail.com>
Message-ID: <CAK8P3a25JH4=XdS_QRBdTpLhsLyc13XYjt9xq8FcXCNUf+DTiQ@mail.gmail.com>
Subject: Re: [PATCH] arm: ioremap: Fix compilation of code which use
 pci_remap_iospace() without CONFIG_MMU
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:i03Zon9Xi090oYejpz+7XGiFFflLcJE8IkbaW4uNd9ZxrQF7hlV
 J9Op4K7JWWWsSZ4/ur8si2a9pTH6V4YpEWjRWgLka+XFvKKvhvejTFol1i8LIB8LWHwAIh4
 ZxogszVPrG4gXSeBy0jWDvwDqVlNW8XF8W2H0yWGaunT8D1njykj90YL/WkgMiHOvqstG2n
 1UcFK6T7vrAm36NyNh+qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:etpEzXKMhgA=:xeeheoknDfu2dYjiHjY/zo
 NHUlXKrkXSj+ST66oGvvU++WUEfiAfZAjNwvVH1qTnsXr8r8Lkk2PAMmWr8t7KqDvh4/qd15t
 efp6c+aANrE6jR0vOvSO8LggUPqAu06dfPjqA6jN7unYqGs6/7iMJ9ZjEUhMpwg7gj4ogsEPe
 Fdvj1rOq3kVK7J1bEamBrePAxLquSNI/83eqkvHfidxZAQfvYeAVEdWtd7a84HEMzLwTRViiI
 BbtBlb0Y5WI86HEtwSg1u7DraQOIMnwpexDM1a34XjL4WmuczXhJw016IJ8MR1F6tu0KTSu8l
 F56eZwAYjyqO39DRhqVP9dnHR6eIXzjayqN/xXDYWwMQEZps6gB365peUxotrkkpJij69sD9P
 WQK29VS9+I0HVnUeYqvS4TSukgRVmwoIh5zJn6tZKU6sshWlHQWAGc4p4QKEc0HN3vFWf48BI
 ynXvyQfUf9LVrxkKM7XjDCNoWjgtZkG7R8Eae7Q62ItFLEFH1PZXT+iUpIoWg/ocpzQM8lNuk
 4lgb5O7+nkVsu7hqKsYFnYiOsog5Z82HFYOOIXabuxXe66GbXYJPrgj5+ufi6QolkpR4gMamv
 qELQ47B2158gCqHURkOc+47u4vPsQcDWAGwZeDl850KVeVxE949UJ8J6w4KU56IqA6s9I+dGz
 hIktHZNho5Fm8Rqhl89HFdbmfLKICVAa5vF3GypB1g888x6sRSgGmGjEQJmMiZu87QrCNt9Xf
 GHKVXVW6VS00ryWJsTQACzbGSjAbYxRnecjzYwY0XMIYAabRbeGkJIRz9xpOpuXpdZLWfRWEM
 Lb3vIGkf9xnvPMrrblVzTLgPdnat5Fywk5Lp7vO86X25JBfXKwD0+QwcyRZ4YztVvgjsgmZjx
 0GmUnnKkxo7/JmTyPhQg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 8:57 PM Pali Rohár <pali@kernel.org> wrote:
>
> Custom ARM version of pci_remap_iospace() is implemented only for MMU
> kernel builds. So do not define pci_remap_iospace() without CONFIG_MMU.
>
> See compilation failures:
> https://lore.kernel.org/r/202112040150.wvyJZIZO-lkp@intel.com/
> https://lore.kernel.org/r/202112261802.u9iXqdWh-lkp@intel.com/
> https://lore.kernel.org/r/202201131529.A2s7rKQc-lkp@intel.com/
> https://lore.kernel.org/r/202203090147.24cUL0De-lkp@intel.com/
>
> Fixes: bc02973a06a6 ("arm: ioremap: Implement standard PCI function pci_remap_iospace()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pali Rohár <pali@kernel.org>
>
> ---
>
> PING!!!! Is somebody interested in fixing these compile errors? As nobody
> answered to my emails where I proposed this fix more than half year ago and
> asked for opinion...
>
> https://lore.kernel.org/r/20211204022131.bmhla4gkph7s7hy2@pali/
> https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/
> https://lore.kernel.org/r/20211226215135.blcnafbuwhrq5ram@pali/
> https://lore.kernel.org/r/20220113134938.3tx7iiukphvazvsq@pali/
> https://lore.kernel.org/r/20220308184851.jmw2xvrapy5wzwof@pali/
>

Are you sure this still happens in mainline kernels? Since
commit 2f618d5ef5dd ("ARM: remove support for NOMMU ARMv4/v5")
it should no longer be possible to disable the MMU in any Arm machines
other than the Cortex-M based ones, which do not support PCI.

         Arnd
