Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C120748667E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiAFPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbiAFPH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:07:58 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5EDC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 07:07:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p13so5504028lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cXGepMZwEZbwx9B77bhjra/s5B3wxBrieWG8GwpKNbw=;
        b=ll9GSFT3XbH/fg6mXPuJuat+1IFUiEi0+PlSvE9CqNqTtuCzxRhqXcCRYM/H72wPVW
         YOl25OFXZMu6u8jxG01z3/wtCwA1qQVSI/opjhVBG9q9YDAnIcBrdY3ePik5tQgu0dwx
         rzpoOC32FkDbjZ/vhSEmK1PnYRA7XzfTeAtq6JkOd83MLYFlMmIR42HeOz+5mpwhWWrT
         tgCKFYpYMyD0q0LavLaXPFOTPmF0jpRi6HG+6WlyRmUbW1AwsIw58mUdy11QLQHlzrDU
         Ans7OnsZL6Jiqfx+TnAhG2JEWVo9cUFav62X7g2dNpf8ZRWjCaJLVaTa9LnkEyYaPCpU
         DPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cXGepMZwEZbwx9B77bhjra/s5B3wxBrieWG8GwpKNbw=;
        b=ltTSEKTN7heDbvMJ3+aPm90Z16ln5cGlvUpx/CDclIiraXE5wrBs7iPHjeOV7DOnEW
         drUnDyO2zryQmAGJdeDvtiVAevjxBrApvMT2qaCRUa0NHKXkDzGpxgTPLS4FTQ94adO7
         Qf1udZ6ijzQByJXWpjwYvOZtC4lPi6erwAfmHJXTrqzrIYRjBI+/SoVBCtdH9YwbRzR1
         G7u/fDuXUC4wZ5LZlKPgoUNS4SEH0xQW45vmOVOfP4bSIuRxIgK8u1eDmVX5oq3DFbad
         5jwjUTYvfgOcsTivlyHZiqZzXTw5TKlLzPxNltKRJCr99saqelVTRR0VdHdpycwuFYnN
         n9sQ==
X-Gm-Message-State: AOAM530xum4UWzJeJgb6sJR19U0pTVMsQhqAI7zpG8UAcj//0IM84mIJ
        90B+St+TAtNvtw3Wp3Dsa67Oqw==
X-Google-Smtp-Source: ABdhPJzNseFYg67l1J30f3kSABvK4QTdcSi5pzk5Pp767+drUkrTxIRE7HRSz6VdFQYVPduohXSJAg==
X-Received: by 2002:a19:6e42:: with SMTP id q2mr51876171lfk.60.1641481676539;
        Thu, 06 Jan 2022 07:07:56 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p19sm190966lfg.217.2022.01.06.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 07:07:55 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B555D103059; Thu,  6 Jan 2022 18:08:15 +0300 (+03)
Date:   Thu, 6 Jan 2022 18:08:15 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220106150815.2upux2pelguazfue@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
 <20211215233116.d2opfoei42viqdty@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215233116.d2opfoei42viqdty@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:31:16PM -0800, Josh Poimboeuf wrote:
> > +static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> 
> Similarly, tdx_handle_mmio() returns (int) 0 for success, while other
> tdx_handle_*() functions return (bool) true for success.  Also
> confusing.

Looked at this again, you read it wrong. tdx_handle_mmio() return size of
instruction it handled so we can advance RIP and <= 0 on error. It is
consistent with other #VE handlers that positive (true) on success.

-- 
 Kirill A. Shutemov
