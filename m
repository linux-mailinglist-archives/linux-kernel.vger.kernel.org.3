Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021584B4070
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbiBNDlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:41:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240068AbiBNDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:41:15 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38FC5621A;
        Sun, 13 Feb 2022 19:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644810067; x=1676346067;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g39Ed6iMdKsuKAJZaUSiQWnjBeVY8RWMK+iVujZLSjQ=;
  b=bm7+9YjeZSYF7c4w1IhorgeHx3rhD1DV8G5N5Ud9F80JfT7AHmw+0aEn
   Jy/5Bq+eKSYnJiCCKsBfYxMqAm0U/qqkb+veMpeDmtX5UJmUkLrHR2den
   U+/DM+iCBnlRnIqISTDVoa1VXQsTgmL43+5pSGlbWQQ5pu2FfFnZiwjXN
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Feb 2022 19:41:07 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 19:41:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Feb 2022 19:41:06 -0800
Received: from [10.50.50.207] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 13 Feb
 2022 19:41:02 -0800
Message-ID: <345db64d-755b-2d07-287a-7f39858533e6@quicinc.com>
Date:   Mon, 14 Feb 2022 09:10:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv9 5/5] asm-generic/io: Add logging support for MMIO
 accessors
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1642482334.git.quic_saipraka@quicinc.com>
 <9d7bf0462a140c1425e304c1e709f82e9132253d.1642482334.git.quic_saipraka@quicinc.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <9d7bf0462a140c1425e304c1e709f82e9132253d.1642482334.git.quic_saipraka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 1/24/2022 12:03 PM, Sai Prakash Ranjan wrote:
> Add logging support for MMIO high level accessors such as read{b,w,l,q}
> and their relaxed versions to aid in debugging unexpected crashes/hangs
> caused by the corresponding MMIO operation. Also add a generic flag
> (__DISABLE_TRACE_MMIO__) which is used to disable MMIO tracing in nVHE KVM
> and if required can be used to disable MMIO tracing for specific drivers.
>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>   arch/arm64/kvm/hyp/nvhe/Makefile |  7 ++-
>   include/asm-generic/io.h         | 82 ++++++++++++++++++++++++++++++--
>   2 files changed, 84 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 24b2c2425b38..228d1f8921c3 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -4,7 +4,12 @@
>   #
>   
>   asflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
> -ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
> +
> +# Tracepoint and MMIO logging symbols should not be visible at nVHE KVM as
> +# there is no way to execute them and any such MMIO access from nVHE KVM
> +# will explode instantly (Words of Marc Zyngier). So introduce a generic flag
> +# __DISABLE_TRACE_MMIO__ to disable MMIO tracing for nVHE KVM.
> +ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
>   
>   hostprogs := gen-hyprel
>   HOST_EXTRACFLAGS += -I$(objtree)/include
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 7ce93aaf69f8..c9b428657760 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -10,6 +10,7 @@
>   #include <asm/page.h> /* I/O is all done through memory accesses */
>   #include <linux/string.h> /* for memset() and memcpy() */
>   #include <linux/types.h>
> +#include <linux/instruction_pointer.h>
>   
>   #ifdef CONFIG_GENERIC_IOMAP
>   #include <asm-generic/iomap.h>
> @@ -61,6 +62,35 @@
>   #define __io_par(v)     __io_ar(v)
>   #endif
>   
> +#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
> +#include <linux/tracepoint-defs.h>
> +
> +DECLARE_TRACEPOINT(rwmmio_write);
> +DECLARE_TRACEPOINT(rwmmio_post_write);
> +DECLARE_TRACEPOINT(rwmmio_read);
> +DECLARE_TRACEPOINT(rwmmio_post_read);
> +
> +void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
> +		    unsigned long caller_addr);
> +void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
> +			 unsigned long caller_addr);
> +void log_read_mmio(u8 width, const volatile void __iomem *addr,
> +		   unsigned long caller_addr);
> +void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
> +			unsigned long caller_addr);
> +
> +#else
> +
> +static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
> +				  unsigned long caller_addr) {}
> +static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
> +				       unsigned long caller_addr) {}
> +static inline void log_read_mmio(u8 width, const volatile void __iomem *addr,
> +				 unsigned long caller_addr) {}
> +static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
> +				      unsigned long caller_addr) {}
> +
> +#endif /* CONFIG_TRACE_MMIO_ACCESS */
>   
>   /*
>    * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
> @@ -149,9 +179,11 @@ static inline u8 readb(const volatile void __iomem *addr)
>   {
>   	u8 val;
>   
> +	log_read_mmio(8, addr, _THIS_IP_);
>   	__io_br();
>   	val = __raw_readb(addr);
>   	__io_ar(val);
> +	log_post_read_mmio(val, 8, addr, _THIS_IP_);
>   	return val;
>   }
>   #endif
> @@ -162,9 +194,11 @@ static inline u16 readw(const volatile void __iomem *addr)
>   {
>   	u16 val;
>   
> +	log_read_mmio(16, addr, _THIS_IP_);
>   	__io_br();
>   	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
>   	__io_ar(val);
> +	log_post_read_mmio(val, 16, addr, _THIS_IP_);
>   	return val;
>   }
>   #endif
> @@ -175,9 +209,11 @@ static inline u32 readl(const volatile void __iomem *addr)
>   {
>   	u32 val;
>   
> +	log_read_mmio(32, addr, _THIS_IP_);
>   	__io_br();
>   	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
>   	__io_ar(val);
> +	log_post_read_mmio(val, 32, addr, _THIS_IP_);
>   	return val;
>   }
>   #endif
> @@ -189,9 +225,11 @@ static inline u64 readq(const volatile void __iomem *addr)
>   {
>   	u64 val;
>   
> +	log_read_mmio(64, addr, _THIS_IP_);
>   	__io_br();
>   	val = __le64_to_cpu(__raw_readq(addr));
>   	__io_ar(val);
> +	log_post_read_mmio(val, 64, addr, _THIS_IP_);
>   	return val;
>   }
>   #endif
> @@ -201,9 +239,11 @@ static inline u64 readq(const volatile void __iomem *addr)
>   #define writeb writeb
>   static inline void writeb(u8 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 8, addr, _THIS_IP_);
>   	__io_bw();
>   	__raw_writeb(value, addr);
>   	__io_aw();
> +	log_post_write_mmio(value, 8, addr, _THIS_IP_);
>   }
>   #endif
>   
> @@ -211,9 +251,11 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
>   #define writew writew
>   static inline void writew(u16 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 16, addr, _THIS_IP_);
>   	__io_bw();
>   	__raw_writew((u16 __force)cpu_to_le16(value), addr);
>   	__io_aw();
> +	log_post_write_mmio(value, 16, addr, _THIS_IP_);
>   }
>   #endif
>   
> @@ -221,9 +263,11 @@ static inline void writew(u16 value, volatile void __iomem *addr)
>   #define writel writel
>   static inline void writel(u32 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 32, addr, _THIS_IP_);
>   	__io_bw();
>   	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
>   	__io_aw();
> +	log_post_write_mmio(value, 32, addr, _THIS_IP_);
>   }
>   #endif
>   
> @@ -232,9 +276,11 @@ static inline void writel(u32 value, volatile void __iomem *addr)
>   #define writeq writeq
>   static inline void writeq(u64 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 64, addr, _THIS_IP_);
>   	__io_bw();
>   	__raw_writeq(__cpu_to_le64(value), addr);
>   	__io_aw();
> +	log_post_write_mmio(value, 64, addr, _THIS_IP_);
>   }
>   #endif
>   #endif /* CONFIG_64BIT */
> @@ -248,7 +294,12 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
>   #define readb_relaxed readb_relaxed
>   static inline u8 readb_relaxed(const volatile void __iomem *addr)
>   {
> -	return __raw_readb(addr);
> +	u8 val;
> +
> +	log_read_mmio(8, addr, _THIS_IP_);
> +	val = __raw_readb(addr);
> +	log_post_read_mmio(val, 8, addr, _THIS_IP_);
> +	return val;
>   }
>   #endif
>   
> @@ -256,7 +307,12 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
>   #define readw_relaxed readw_relaxed
>   static inline u16 readw_relaxed(const volatile void __iomem *addr)
>   {
> -	return __le16_to_cpu(__raw_readw(addr));
> +	u16 val;
> +
> +	log_read_mmio(16, addr, _THIS_IP_);
> +	val = __le16_to_cpu(__raw_readw(addr));
> +	log_post_read_mmio(val, 16, addr, _THIS_IP_);
> +	return val;
>   }
>   #endif
>   
> @@ -264,7 +320,12 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
>   #define readl_relaxed readl_relaxed
>   static inline u32 readl_relaxed(const volatile void __iomem *addr)
>   {
> -	return __le32_to_cpu(__raw_readl(addr));
> +	u32 val;
> +
> +	log_read_mmio(32, addr, _THIS_IP_);
> +	val = __le32_to_cpu(__raw_readl(addr));
> +	log_post_read_mmio(val, 32, addr, _THIS_IP_);
> +	return val;
>   }
>   #endif
>   
> @@ -272,7 +333,12 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
>   #define readq_relaxed readq_relaxed
>   static inline u64 readq_relaxed(const volatile void __iomem *addr)
>   {
> -	return __le64_to_cpu(__raw_readq(addr));
> +	u64 val;
> +
> +	log_read_mmio(64, addr, _THIS_IP_);
> +	val =__le64_to_cpu(__raw_readq(addr));
> +	log_post_read_mmio(val, 64, addr, _THIS_IP_);
> +	return val;
>   }
>   #endif
>   
> @@ -280,7 +346,9 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
>   #define writeb_relaxed writeb_relaxed
>   static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 8, addr, _THIS_IP_);
>   	__raw_writeb(value, addr);
> +	log_post_write_mmio(value, 8, addr, _THIS_IP_);
>   }
>   #endif
>   
> @@ -288,7 +356,9 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
>   #define writew_relaxed writew_relaxed
>   static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 16, addr, _THIS_IP_);
>   	__raw_writew(cpu_to_le16(value), addr);
> +	log_post_write_mmio(value, 16, addr, _THIS_IP_);
>   }
>   #endif
>   
> @@ -296,7 +366,9 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
>   #define writel_relaxed writel_relaxed
>   static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 32, addr, _THIS_IP_);
>   	__raw_writel(__cpu_to_le32(value), addr);
> +	log_post_write_mmio(value, 32, addr, _THIS_IP_);
>   }
>   #endif
>   
> @@ -304,7 +376,9 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
>   #define writeq_relaxed writeq_relaxed
>   static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
>   {
> +	log_write_mmio(value, 64, addr, _THIS_IP_);
>   	__raw_writeq(__cpu_to_le64(value), addr);
> +	log_post_write_mmio(value, 64, addr, _THIS_IP_);
>   }
>   #endif
>   

Does this version look good to you? I would rather this series spend 
more time in some testing branch
than on the list.

Thanks,
Sai
