Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0866B4BC1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiBRVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:25:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbiBRVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:25:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1A123F0A3;
        Fri, 18 Feb 2022 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645219495;
        bh=8Qbp9ywMfLLJGNDUfXa/H7AcuBYMzUpeopGjalIQ8jM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=duwlvrRfWriC8JRaADzI/uCCfClLIoyZ5OBOOCVsOhKllVONmxmZ7nCQWZ4GIKfog
         9QpZrULjL2n0AbCYIa8ZJ29PPdMGjatujtMylhwy0h/df9yJ6n/5B9DE/7hhpnJM5M
         oseBLS3xubRNQot4Eeew6QXa6/IQ1cyNk6T3z6i0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.159.38]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1niw1R1e7i-00WYDt; Fri, 18
 Feb 2022 22:24:55 +0100
Message-ID: <882c62b7-78a2-f443-c8c5-0477fdf5d306@gmx.de>
Date:   Fri, 18 Feb 2022 22:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] parisc: Use the VMA iterator in the cache handling
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-parisc <linux-parisc@vger.kernel.org>
References: <20220218203418.831810-1-Liam.Howlett@oracle.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220218203418.831810-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UGZ1uZhVMlR3cLLTsfmuip3Abwu7MtsoH9hav8BXru7GId0WAwQ
 F9uzWA2ZfGi+WaA3sQLlDKBV/ATrbBiBY0S+s7qSN+b5vV9eXi95ntzDKCgCkumG+k00UyD
 oPeK7BUWykdscKAWNaqWDcLIrlYSlgVvp524BQMgkM94JTVZFTYsSeov3CsD2TPYztAC9E6
 E4JHC/A34qVLuvbF9gbhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGndFVT3Bw4=:4AC9CvME+11yPtbG7gF5aP
 cA96Ok9NE+9Kbiq8iuv+tO3di4n6XN58YrQji40WEvy+v6XPoSUqGAB8PPI2k5Fp4Uxmq1jMi
 ctq2/9TmCZW9AlOf285Ijl200JsrTT39W/n/PrVk3xSfm8dPSt2CHNw/x3u8cYfEL6wCzlAcE
 Rjgi6Fj/JV9lUG+VdQCFlQf4TeHE8rxxc7razIO+hRlFHGseqkDyn11vClIkAvQ+EFn2N9V2S
 Qg6B6AxGQA/Fuweuy4aJogMEcsSlo3oa5ihB+A01Zdx1Ul/JIwIrm6t3CwPVDGCrPNc9PWAXS
 A9C6je63hY0JGnt7gtJhEXSHwB3wYLRU6f2zUbfhM98poy7Hd4FNQ81zIQnKZg65k1GmEcO0D
 tARUAvEkt6DhrUFJ4R3h3/ZGl4TrEvaZqiIRWgkJX+Gg+tW1vd+f3Dkx9W2NSFs6mK6KbdNPK
 kGWnyovz4zwM8jxkPrtBylUP4eiYoEnmscUh7jPdkdW7+40fQuLY+YbgtMpZ9q2TTzSdT3YeR
 zFzUuZXlPlealGyHmhNgyjfMEGJ0HPQCYgIJ0aAL9qLpbnoznvGZfF1FQf7TPHKuPWQvwbTWK
 eLlHwUJrHs5ZVcGU/Cq99WTw4mF1m51ZpUUNBtAuAKL14E4wDSd7sBCdzeYaOal0gRFr0m3jB
 GPtqd499BZD4udTa6C0rQFwZS+ACPL3ngu2tokxG2FI+KZ+T9CwqrT0dXOtyxgr8fGqSmHP2i
 MPf1lDCmGcvZFUHiqdCw87SnLEYfXFB+DK2cZ9k4WodvHH/DWJZgAEbo4ca5LorE3faJyRvvH
 HjBL6YWxKc6qsYvyyZZsxBKl7Bcy4BFcF8DO6oO8XmckU9BsNmem3EPFWGq8m14EOZP90X/md
 cBBhtmMG0MzkvF/AXqBb+CT0KbglsHpF18sbn3anpwDfMANTin5WP8xLL8g44sPJgevcGd312
 5c5+tA8jQr7L8zJpiGeKUGiJVo9o6eb04Oj0P8yhr4G9BqGgL7XATE2yeVp943nMkX9gDoCg8
 WQgO4pCyXGCP97iH1gWWIOBHWlNQhDWiDTrCdlShppiqm0fat9jdQxM15PCugvcPL0OsOKHhB
 vEUEWOmdM4GvfQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 21:34, Liam Howlett wrote:
> This patch is on top of the parisc branch for-next.
>
> Helge Deller identified a conflict between the maple tree next branch
> and the parisc next branch.

Actually, Stephen noticed and reported it with the linux-next branch...

> This patch removes the vma linked list
> usage in the parisc next branch identified by Helge as a conflict to
> maple tree "parisc: Remove mmap linked list from cache handling" and the
> parisc "parisc: Add vDSO support" patch.  I do not expect this to apply
> cleanly after the maple tree next merge, but the resolution should be
> made clear by this patch.
>
> This is an untested conflict resolution for linux-next.

Thanks for doing this, Liam!

I'd propose to keep for now (for the linux-next tree) the conflict resolut=
ion
fix which Stephen has in place already, and then figure out when the
merge window opens how to resolve it - either you or me or fixing afterwar=
ds
with this patch.

Would that be ok?

Helge

> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  arch/parisc/kernel/cache.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> index e7b8e74dad8e..05b4498a1244 100644
> --- a/arch/parisc/kernel/cache.c
> +++ b/arch/parisc/kernel/cache.c
> @@ -515,12 +515,12 @@ void flush_cache_all(void)
>  	on_each_cpu(cacheflush_h_tmp_function, NULL, 1);
>  }
>
> -static inline unsigned long mm_total_size(struct mm_struct *mm)
> +static inline unsigned long mm_total_size(struct vma_iterator *vmi)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long usize =3D 0;
>
> -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> +	for_each_vma(*vmi, vma)
>  		usize +=3D vma->vm_end - vma->vm_start;
>  	return usize;
>  }
> @@ -570,11 +570,12 @@ static void flush_user_cache_tlb(struct vm_area_st=
ruct *vma,
>  void flush_cache_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
>
>  	/* Flushing the whole cache on each cpu takes forever on
>  	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
>  	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
> -	    mm_total_size(mm) >=3D parisc_cache_flush_threshold) {
> +	    mm_total_size(&vmi) >=3D parisc_cache_flush_threshold) {
>  		if (mm->context.space_id)
>  			flush_tlb_all();
>  		flush_cache_all();
> @@ -583,13 +584,13 @@ void flush_cache_mm(struct mm_struct *mm)
>
>  	preempt_disable();
>  	if (mm->context.space_id =3D=3D mfsp(3)) {
> -		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> +		for_each_vma(vmi, vma)
>  			flush_user_cache_tlb(vma, vma->vm_start, vma->vm_end);
>  		preempt_enable();
>  		return;
>  	}
>
> -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> +	for_each_vma(vmi, vma)
>  		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
>  	preempt_enable();
>  }

