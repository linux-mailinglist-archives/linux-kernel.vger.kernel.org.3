Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521B14EE404
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242442AbiCaW3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiCaW27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:28:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02AD249C43
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:27:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso3634555pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UGTTLM5KwdelLI1VtyfoCZNZpzMLIVy+TmklmTZiKBE=;
        b=OeelOoTlY6TqHjI6jnJEPOZtPmywhHwFU5PYLzUYWNqHpovPkDcc77sd+H/hnXpeGn
         SgaRg1zjdPbSYYdVCYhkPXxVSZDgNE18Z1UkoF9FuPPipMFJwWqPklkOXHadIF8jEr+t
         YcBTSQVuV0j+Us+u8rwIIkmBXF6wL6vN4ye+sG90Co+KfcYLeDQ5S118SAvEUwBSrBGn
         murWArPh51ijI0fwrPFnFf6/32+dfWD8+GrbZN4p4suALijE1Bgv6wa3bE/45rSk8dbV
         GIOMvgzqZEGgTFRmDNRSmuwbzyhXlNMjhcxFgtuVOwJmRz3OwAxF6Tyfq2/wNf9rxPqT
         mztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGTTLM5KwdelLI1VtyfoCZNZpzMLIVy+TmklmTZiKBE=;
        b=pZr1w+bR4KG5Lx/Kc4BUjCEqZ4hEZTGZeUh8nwVmAjMmwysA3wRbuL6sd+wrU6B+JY
         oF79rdr+g4yt1Qc1Dy3Jxi/1NUFN5txJT+6DPoMXjR2ngoQyc5DF5lGiJqKHqhgMYI1W
         fdCGFEy+i1c0lYqP7OYTK9hiBMKEXC1GGtnpeb0ifTfTxYhipwoZ6I+ZpAjbutKcCylB
         717bJW6JrZTV+olO4xtLDrnp3Es/c63k1RN+jrRhFbNPmlftf/QCtB+YZO3X6uAcxp7q
         yTqc5v3XdLkpnWX4UrHhlbm/jOiZc11tbRGBM6aGSpSu6re7SsAabIA8wbK1kQuSrYDh
         +0Uw==
X-Gm-Message-State: AOAM531ic4bUw/v3WjKn02KUTyakdB6b8gdwVKepn2/LiEDoED/oc783
        7/q3CsOoU9/5t2Xgc0bGB3Uf3w==
X-Google-Smtp-Source: ABdhPJxzp3+4FNR5zB1aoc75aqa5jCF4E1pX+5cqO1ZHj3iTIM//NVXx6G3jLRz+TtqGlWrUbcWDsw==
X-Received: by 2002:a17:902:82c1:b0:155:ecb7:e018 with SMTP id u1-20020a17090282c100b00155ecb7e018mr7492538plz.59.1648765631025;
        Thu, 31 Mar 2022 15:27:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm338009pgn.2.2022.03.31.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:27:10 -0700 (PDT)
Date:   Thu, 31 Mar 2022 22:27:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Gao Chao <chao.gao@intel.com>,
        Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v7 2/8] KVM: VMX: Extend BUILD_CONTROLS_SHADOW macro to
 support 64-bit variation
Message-ID: <YkYquqLOduNlQntZ@google.com>
References: <20220304080725.18135-1-guang.zeng@intel.com>
 <20220304080725.18135-3-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304080725.18135-3-guang.zeng@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022, Zeng Guang wrote:
> +#define BUILD_CONTROLS_SHADOW(lname, uname, bits)			\
> +static inline								\
> +void lname##_controls_set(struct vcpu_vmx *vmx, u##bits val)		\
> +{									\
> +	if (vmx->loaded_vmcs->controls_shadow.lname != val) {		\
> +		vmcs_write##bits(uname, val);				\
> +		vmx->loaded_vmcs->controls_shadow.lname = val;		\
> +	}								\
> +}									\
> +static inline u##bits __##lname##_controls_get(struct loaded_vmcs *vmcs)\
> +{									\
> +	return vmcs->controls_shadow.lname;				\
> +}									\
> +static inline u##bits lname##_controls_get(struct vcpu_vmx *vmx)	\
> +{									\
> +	return __##lname##_controls_get(vmx->loaded_vmcs);		\
> +}									\
> +static inline								\

Drop the newline, there's no need to split this across two lines.  Aligning the
backslashes will mean they all poke past the 80 char soft limit, but that's totally
ok.  The whole point of the line limit is to improve readability, and a trivial
runover is much less painful than a split function declaration.  As a bonus, all
the backslashes are aligned, have leading whitespace, and still land on a tab stop :-)

#define BUILD_CONTROLS_SHADOW(lname, uname, bits)				\
static inline void lname##_controls_set(struct vcpu_vmx *vmx, u##bits val)	\
{										\
	if (vmx->loaded_vmcs->controls_shadow.lname != val) {			\
		vmcs_write##bits(uname, val);					\
		vmx->loaded_vmcs->controls_shadow.lname = val;			\
	}									\
}										\
static inline u##bits __##lname##_controls_get(struct loaded_vmcs *vmcs)	\
{										\
	return vmcs->controls_shadow.lname;					\
}										\
static inline u##bits lname##_controls_get(struct vcpu_vmx *vmx)		\
{										\
	return __##lname##_controls_get(vmx->loaded_vmcs);			\
}										\
static inline void lname##_controls_setbit(struct vcpu_vmx *vmx, u##bits val)	\
{										\
	lname##_controls_set(vmx, lname##_controls_get(vmx) | val);		\
}										\
static inline void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##bits val)	\
{										\
	lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);		\
}

With that fixed,

Reviewed-by: Sean Christopherson <seanjc@google.com>

> +void lname##_controls_setbit(struct vcpu_vmx *vmx, u##bits val)		\
> +{									\
> +	lname##_controls_set(vmx, lname##_controls_get(vmx) | val);	\
> +}									\
> +static inline								\
> +void lname##_controls_clearbit(struct vcpu_vmx *vmx, u##bits val)	\
> +{									\
> +	lname##_controls_set(vmx, lname##_controls_get(vmx) & ~val);	\
>  }
> -BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS)
> -BUILD_CONTROLS_SHADOW(vm_exit, VM_EXIT_CONTROLS)
> -BUILD_CONTROLS_SHADOW(pin, PIN_BASED_VM_EXEC_CONTROL)
> -BUILD_CONTROLS_SHADOW(exec, CPU_BASED_VM_EXEC_CONTROL)
> -BUILD_CONTROLS_SHADOW(secondary_exec, SECONDARY_VM_EXEC_CONTROL)
> +BUILD_CONTROLS_SHADOW(vm_entry, VM_ENTRY_CONTROLS, 32)
> +BUILD_CONTROLS_SHADOW(vm_exit, VM_EXIT_CONTROLS, 32)
> +BUILD_CONTROLS_SHADOW(pin, PIN_BASED_VM_EXEC_CONTROL, 32)
> +BUILD_CONTROLS_SHADOW(exec, CPU_BASED_VM_EXEC_CONTROL, 32)
> +BUILD_CONTROLS_SHADOW(secondary_exec, SECONDARY_VM_EXEC_CONTROL, 32)
>  
>  /*
>   * VMX_REGS_LAZY_LOAD_SET - The set of registers that will be updated in the
> -- 
> 2.27.0
> 
