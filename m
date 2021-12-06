Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A195546A069
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444990AbhLFQDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358438AbhLFPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:52:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA6C036FAB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:37:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so7311617plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7HzwmvjWwTv0FeXPfbk2piEjvWmlmu/Ix95bAO30KVA=;
        b=ZhuBW1c4dJPnblkwVVq7/i5JD1acaN3vKRPqk1vt1l4/1WVncLZ6/XF7i5mu75gzgu
         gjeCchw5SEdKY9IS6B7CPAfcmRrUtycY7KuXQmFjBHQHAkwiOcZJ9z0v/+YNWbTW74ju
         WW96J+3JEIUppGf6QeHbGWa7GVsgIexlxyh9hOk48GZohQPBwAtQkqiajM6rP2eObXpU
         BB9FK4L4OBLFpwyu9xrfcQ8X7jt5+ieR5WZzveGHAm+q8YpxPYGnxSwBq7pubQ1wuMhA
         A0WTx//Jdi0jZnVSCUhuNTOI/Ivk6mePXx6gLqDkkdRd+Kgm/eFjcy+0vGQqU+5gDD/C
         DlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7HzwmvjWwTv0FeXPfbk2piEjvWmlmu/Ix95bAO30KVA=;
        b=JIh7Du4Z87joOLyNtbbAPX8izo2OwwgB45kZP1/06cdk4L8qbadrA15AVluEPr+D8Y
         UQICZ5SWbqiR2w83jODT7uAlgzQMKRmE+Zrfdq6KCk7nNn3tmv0qdtJ82tJH//nV1L4A
         s02fwOGAsh49hTRV1zzxkrBx3fnqOXD3rlTVteR6wrCOUG2c0GGtBpc8LwQ6Ijhtacs4
         uz96pLMjz6hqPBqnb4aqrAyYqYM16jpyT35uElQvr6hUptJEenj7kdAduEGOcSSv0rcb
         adMNE1d7QppFq/tv8n7laYCUsmthdtNgic/FLmBpl6/B+GfIipO5BdYC95DAjLvwmLMS
         kiqQ==
X-Gm-Message-State: AOAM5321+pNuvQzPvOGV0NRvP8rorXXso8UQl5MnyzD9Aw7SnLi4RONj
        hgyCOC0Mu4HAYvkXIG/cWfdftg==
X-Google-Smtp-Source: ABdhPJwcn3YT+bEUgsZ2X+gC+fgtI4ggBTfe1/BDgoKckLhZ5wuo1mJvX1iNXW4oitVJUGRb6dnE1Q==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr37953644pjb.62.1638805067801;
        Mon, 06 Dec 2021 07:37:47 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id lr6sm11226043pjb.0.2021.12.06.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:37:47 -0800 (PST)
Date:   Mon, 6 Dec 2021 15:37:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2] KVM: x86: fix for missing initialization of return
 status variable
Message-ID: <Ya4uR7I/7yvrgl6c@google.com>
References: <87ee6q6r1p.fsf@redhat.com>
 <20211206102403.10797-1-amhamza.mgc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206102403.10797-1-amhamza.mgc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021, Ameer Hamza wrote:
> If undefined ioctl number is passed to the kvm_vcpu_ioctl_device_attr
> function, it should return with error status.

No, if anything KVM should do KVM_BUG_ON() and return -EIO, because @ioctl is
completely KVM controlled.  But I'd personally prefer we leave it as is, there's
one call site that very clearly invokes the helper with only the three ioctls.
It's not a strong preference though.
