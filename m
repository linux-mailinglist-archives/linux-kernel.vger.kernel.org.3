Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6616B52546D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357464AbiELSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357463AbiELSEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:04:24 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA126C4F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:04:22 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-ed9a75c453so7569576fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RDvciQFODhdDBATVVOib/Gmk+OU/HVoyX0M9V8aGmGU=;
        b=OhoyWF65mi0OD1ZrwD8K8tghppxQ4nj2MSuR5Is/a/fBxZfTq1JIIHFG0ErtJrVzDY
         Lfte8BPrMs3i/p5Ri02BkwX7KGT4cInuluoAqkOJoKXCQhGZrs0U05Iaco9ILhvaGzwK
         a8EKtmSy9vcAVrmbRbkcd+YW3pSO4sJwTbeVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RDvciQFODhdDBATVVOib/Gmk+OU/HVoyX0M9V8aGmGU=;
        b=CjSGc/ukZ8+/VMUF2jPUaQLrkNoJ8zwD3FRSI7oCqfJjsnM4uY6a4Ghvl/sbI2EE9W
         cmKS/4wwArfFsPS4zfr3bdRIA7GRMawsyTFIAFATNX6pxCyd4VTzmwE3P8BdYsrOh3yq
         oYoinrMs2a+fRXbikVcYrnJYUWdw5h/oCHFv+30I/Qmnp2v8pd0ucub5kGu55oRk+UiJ
         TCnvj2d3MFDcedHTI51cwJjmyWR5+u9OYHxXPrRFpH9AHvmJPqsD5MliTckNSfnpB2gB
         9BF0YkoOmNI4m3M7DL0lt7TIO42eEV4J+9/AsdLXN14Qhud3Nl0JPCbFVyKwXbRgOWgM
         rH8Q==
X-Gm-Message-State: AOAM533oPNBaS1PZUb2zfE1Sx/pYSyWdNweKCzs/IfMa0AHnS1cGgB4r
        Bl2kAt2Jp6Rzco9qzDSn+u6E+Q==
X-Google-Smtp-Source: ABdhPJzIgybtu7P78NikEpr7S0+QoB5xWkWXzrunFCazvRkHmyFG0lM9FsiggE8wyigSv4bUgRm6Lw==
X-Received: by 2002:a05:6870:1791:b0:e2:f75b:b15f with SMTP id r17-20020a056870179100b000e2f75bb15fmr592903oae.106.1652378661796;
        Thu, 12 May 2022 11:04:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l93-20020a9d1b66000000b00606aa21608esm149238otl.17.2022.05.12.11.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 11:04:21 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 0/8] selftests: KVM: selftests for fd-based
 approach of supporting private memory
To:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, yang.zhong@intel.com, drjones@redhat.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
References: <20220511000811.384766-1-vannapurve@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e4a84dfe-2397-0881-b6bd-1cb2b2d5904e@linuxfoundation.org>
Date:   Thu, 12 May 2022 12:04:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220511000811.384766-1-vannapurve@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 6:08 PM, Vishal Annapurve wrote:
> This v2 series implements selftests targeting the feature floated by Chao
> via:
> https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
> 
> Below changes aim to test the fd based approach for guest private memory
> in context of normal (non-confidential) VMs executing on non-confidential
> platforms.
> 
> priv_memfd_test.c file adds a suite of selftests to access private memory
> from the guest via private/shared accesses and checking if the contents
> can be leaked to/accessed by vmm via shared memory view.
> 
> Updates in V2:
> 1) Tests are added to exercise implicit/explicit memory conversion paths.
> 2) Test is added to exercise UPM feature without double memory allocation.
> 

+ shuah <shuah@kernel.org>

Adding  my correct kernel.org address. Please make sure to run
get_maintainers.pl to get the right addresses for miantianers.

thanks,
-- Shuah
