Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88254AC425
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384519AbiBGPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357953AbiBGPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:40:00 -0500
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 07:39:59 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A57C0401C1;
        Mon,  7 Feb 2022 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644248397;
        bh=YQj3vPcnwi3cE5Dn5MfSTOTMz7U71PyStc3d5A2SNTU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jUmhxZjSH9Kag1INMlad03Br/SQY1EREd9yysOGCsA85CGiE00UEoPaz3zaqvnU5W
         C3C9Hocptjqvg/aIXg111hxDR/6rwQDhsPzbpoxaT5CgL4WD6qVfETP+h2fUQSYaxq
         HnSQG334tmb4QIFht6lYI6HNfQCx7A6EKr1uWewA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.138.144]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1nagKA14cD-00KAi2; Mon, 07
 Feb 2022 16:34:43 +0100
Message-ID: <d0074e49-35c9-99a6-436f-0fdffb0314d8@gmx.de>
Date:   Mon, 7 Feb 2022 16:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 1/1] parisc: Add ioread64_lo_hi() and iowrite64_lo_hi()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20220207151639.75086-1-andriy.shevchenko@linux.intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220207151639.75086-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i0jfZ7DEIUxub3MX6rDALJenx71AamFMGKEyrP4o5SvYFGXoPIu
 ivB6ShyXBn+TPBV7NHJw+qCJ9Wlcx4H5pCvr2SEDlnWoBDXGI98T2aBgv/+vPL72YyB1Jd2
 NLCoCPDgHVSpJVZyKSXRMp85sFn8EPwLmnnC7uJN0rWhtPTZpGHi7d9YWxeYEIdH9dLMUUX
 bMYkf6xf6+JOVUwIffb+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:diGYrKkDPAY=:ZbHjGafRN+kTNTvzt1eRbi
 E3AHnvm7cziPI8UrKDHfiLlfrmfdWYH3yHn+aHIOdJQ95ALuflJVHhEqxdOX5EwYAv6fiA93w
 Mqvx5YvoRHez0BPaORo0nZeiH0UhzyxmeNqjg3vlKOcw7Q6vBbuqTSRbzdQ/koDtSl3TyVfzI
 WKMh6ZS/g7ZkND+F+eOB5nsl1iZJPUsIdWXBdcxVDk1fB6rtdYoLyhdJtz8dyWQHzdnWe5/b1
 7NxpIkLoyQdcg1S4xTSmH90KKlixywCok161HWDfFl2HY0JIXL8sYu+ToERAvEtyzkTDAvfYO
 kaJbE3UR8+3nPJI79In14mCTKzFvKer7CFIkBJNOgl8DcRFC7s6mPNxJimdhYZRYMVgw1nFS5
 coUpF11ZaPbwcHFSbfIUO9e+jfjWPvZjUt1il5b0FIBBCMlpL3YTtfxQpFCmdxqpbLrT1bhOz
 WXQdTFlo6slvxIRUlkC1T7TkOEgDj/4f21OQpRT0Da8iv8MuI3Yk8mmo9acHQEU3dPsORgt++
 NdJ2hQWyjh7OeLEok1f/lIzIzQQoVNeR6OlTdD7+tl9/nbXkZJ8ecquAjBtSaW+cYZL6QGwB2
 NCoSuW+xYtU3CudGV7YyW3ICK4ODB41v5u19wercAultFejWRsVQUrDFz6lXj+a+rxcpaPSXi
 ho2qmXanJCuWuLVs9eKnI2kSjEDOPb2E1+HWtSMsSwTa183H9LcSuyXoyWe8OpBdXiXGTvZN5
 h0SQ0jzf/Ep5WOUegI83qgVv5TPCgJRlanpJsZOQRCVIq1v0TDhyCZLGE6p+w+DrI1qvjjk8O
 ic8dgVrV+qEJrFv3v5OjIbwizLkXZ623dPjNW5Bm7rGTDgARkTB8HZKD9QKKY6yiijZy9lhN+
 1bMEb7bu/IZZnhKDMy5OHFNWy3tJjkcYMu3S3Sr7EAlYp7em//WrOYxD5g+N8uCzSZn9U8baV
 wpB9MKocSkjiOuGlIalFaykS49WW/w4jXPCogNgTAdoIFJEPNX9njK0bGKFjlUGSRIpL46pYC
 S/VoAMflZscVGgckvOFGynzgWsCrLaX/fmt5vK7QOS+wgXkKX38jOIS7gnXNn1oEXsVx2TCrS
 dkadg8EPLoUCsY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 16:16, Andy Shevchenko wrote:
> It's a followup to the previous commit f15309d7ad5d ("parisc: Add
> ioread64_hi_lo() and iowrite64_hi_lo()") which does only half of
> the job. Add the rest, so we won't get a new kernel test robot
> reports.
>
> Fixes: f15309d7ad5d ("parisc: Add ioread64_hi_lo() and iowrite64_hi_lo()=
")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

applied to the parisc for-next tree.

Thanks!
Helge

> ---
>  arch/parisc/lib/iomap.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
> index 367f6397bda7..860385058085 100644
> --- a/arch/parisc/lib/iomap.c
> +++ b/arch/parisc/lib/iomap.c
> @@ -346,6 +346,16 @@ u64 ioread64be(const void __iomem *addr)
>  	return *((u64 *)addr);
>  }
>
> +u64 ioread64_lo_hi(const void __iomem *addr)
> +{
> +	u32 low, high;
> +
> +	low =3D ioread32(addr);
> +	high =3D ioread32(addr + sizeof(u32));
> +
> +	return low + ((u64)high << 32);
> +}
> +
>  u64 ioread64_hi_lo(const void __iomem *addr)
>  {
>  	u32 low, high;
> @@ -419,6 +429,12 @@ void iowrite64be(u64 datum, void __iomem *addr)
>  	}
>  }
>
> +void iowrite64_lo_hi(u64 val, void __iomem *addr)
> +{
> +	iowrite32(val, addr);
> +	iowrite32(val >> 32, addr + sizeof(u32));
> +}
> +
>  void iowrite64_hi_lo(u64 val, void __iomem *addr)
>  {
>  	iowrite32(val >> 32, addr + sizeof(u32));
> @@ -530,6 +546,7 @@ EXPORT_SYMBOL(ioread32);
>  EXPORT_SYMBOL(ioread32be);
>  EXPORT_SYMBOL(ioread64);
>  EXPORT_SYMBOL(ioread64be);
> +EXPORT_SYMBOL(ioread64_lo_hi);
>  EXPORT_SYMBOL(ioread64_hi_lo);
>  EXPORT_SYMBOL(iowrite8);
>  EXPORT_SYMBOL(iowrite16);
> @@ -538,6 +555,7 @@ EXPORT_SYMBOL(iowrite32);
>  EXPORT_SYMBOL(iowrite32be);
>  EXPORT_SYMBOL(iowrite64);
>  EXPORT_SYMBOL(iowrite64be);
> +EXPORT_SYMBOL(iowrite64_lo_hi);
>  EXPORT_SYMBOL(iowrite64_hi_lo);
>  EXPORT_SYMBOL(ioread8_rep);
>  EXPORT_SYMBOL(ioread16_rep);
>

