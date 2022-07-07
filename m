Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4452B56AC9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiGGUSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiGGUSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:18:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87AF205E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:18:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 73so5081071pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1bCm969XGgaOkqh4eRSQbwrpF0kvcOdbQDiSoaqggZA=;
        b=Zak8jiTq85bczrwETGrZMCWPGn3uIDl2243XVn3Cka9H68zrC7vNFRcZEOnmJgrTFd
         Wr9mmzUXkp8oLEloQextca673lYKEvA61aY2CVXnh+R2i9sjKJVCFmba9HEKjzAdNBUP
         NjsfCc0sUnPhxERGS1i6EE8p0QBXetVyScGxOj8ijgpAdFc30gTP9YFlgyYYsD2BPfKF
         uYQSAHfzZsQyLqEzKeHUwmmTqWPr76vRn2dymaBXj8HAJzHklWGuYrC5qplBQhHEl+aW
         PVMz2DUB8v49XBYahpDbUCE1BVEi9qTxI2kavjktAeIzZBo3vtgONMGS8Fs8nrYFe2L/
         oqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1bCm969XGgaOkqh4eRSQbwrpF0kvcOdbQDiSoaqggZA=;
        b=kEcXgix9zk+axv8K1toO3CMJ3mgIE2tW6ffVD6NGP9McDgFTAlKTtMkYV+cQx2fltp
         Jd+hs3uZCLcJQPwePguf5wx+Sr9gcAqTMg/RGQ7x9u4FUmlPXmVFxoOFjyKHBQ72Mjd4
         KDLrK6YvORe1n7vZWzVXhRIrMfY6Shun4plX+GIS2VPQsHQ0CWJCCNBGHXZr9impbQ/h
         xbrSxTB7w23zBzb/fY+htNPXMhndE4iH8M/8S/JH6y2ju2DyBl7SbmlTdvgXakiXFvyB
         7vng2W10HAK02nn8YVeZCmhoQrxouUczew0nv5LVcIB41crhr5VVLWss02Llp7r2yoyi
         DQ7A==
X-Gm-Message-State: AJIora9rVo4m2JcyvoK0FlY702jqyFBlFvdKdKDr9iGculXJPY744mqn
        xmdmn8+5aKDMx6qaltNxXMTPlA==
X-Google-Smtp-Source: AGRyM1u7Vnw+L1f3h+y+anT6YpnUnamRUClSCjg14JDJMI45LSX0ApzgomkSHh6BXqdmDdTFpVMlIA==
X-Received: by 2002:a17:90a:2c0d:b0:1ef:c839:c34b with SMTP id m13-20020a17090a2c0d00b001efc839c34bmr7189286pjd.39.1657225094391;
        Thu, 07 Jul 2022 13:18:14 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id o188-20020a625ac5000000b0052a198c2046sm229368pfb.203.2022.07.07.13.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:18:13 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:18:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Replace UNMAPPED_GVA with INVALID_GPA for
 gva_to_gpa()
Message-ID: <Ysc/gaTYjJNkuq9u@google.com>
References: <6104978956449467d3c68f1ad7f2c2f6d771d0ee.1656667239.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6104978956449467d3c68f1ad7f2c2f6d771d0ee.1656667239.git.houwenlong.hwl@antgroup.com>
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

On Fri, Jul 01, 2022, Hou Wenlong wrote:
> The result of gva_to_gpa() is physical address not virtual address,
> it is odd that UNMAPPED_GVA macro is used as the result for physical
> address. Replace UNMAPPED_GVA with INVALID_GPA and drop UNMAPPED_GVA
> macro.
> 
> No functional change intended.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
