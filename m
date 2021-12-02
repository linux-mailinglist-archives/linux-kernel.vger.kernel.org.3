Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB34B466AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348866AbhLBUma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348828AbhLBUm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:42:29 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE83C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 12:39:06 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 193so1228443qkh.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 12:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfpOB/YwxBkZmHMU1DG9r5qDFp0zinpAqA+jC5ucWk4=;
        b=LzS1sKk/TTReAFEWlKUApPCYo+W6v9VRQwvJi0oULSe22j8TmhbOThj9BS9hdaQ+6M
         gWnPk4ETvcOQT8RcTgyiseviofwFhJ4o/WgWI1prBz1JZtD7S35fRzyTAkoFT8VTciYu
         v8DhFQXUEmkynzpEzwWfYSuALGBNZqtT7fAeHuw0Ziclrq6PIuntDNAocvAsJs6EehZd
         HSQskYlmz26JvlX4QZdSE0d9KDr5BAHke8x/OPvIqK7yVbGmanxnPtdv2/J1s7VwA9qM
         T33CPBfMJyIERRMecJnf1oDyq7xTuX55tc0Du/1JJqd4a/Z+HzoJG+zoNiMlCUyqvFkd
         41ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfpOB/YwxBkZmHMU1DG9r5qDFp0zinpAqA+jC5ucWk4=;
        b=SR8kmzN6ZDSEsP2BaONK0LZaaom0h5hlfpI0AjDhYTEd1eLL8P4AeellhQsvpsrZJ2
         DjHx9nhUlIAgfWfNebz0e3fR6gOLCYiNqAcQMjtl04pMjUXTfeZaAgtGSNpLru+k72dK
         3Qtm8kiC45TPuxArRovy/x10UE9EUxV5WxoQclIhm3oCNgStxDtbn7rzq1htHYtfRr3B
         LVV1Dn5VFQs4mBhXDxYqdhCiE3d1Mhg5P/jnzs3rKrCM0mYDLTYkUpH0EjN5/n7atjm+
         oe+/WZYbmUPd8Ilji8vdaEmaPctIBHpFYuQBFg4dPc85pwknhNjGi2rOCRWb78oseq5Z
         iwKA==
X-Gm-Message-State: AOAM530Jo36H5THEr4gjdwRP4WLE4+eGcnvTO6uWy1IxKngD/quT82Oz
        18uoqPse7OUhijPCCd3xyDjn2540SVR9aEJCCWIMig==
X-Google-Smtp-Source: ABdhPJwjRjpZnsXo8YziSlyzXGi+3LwY0M2piBNCr8jHpLSss4W4bgiO5A16H4+If8K6pshum+1rZfhjBc5CGvoFV6o=
X-Received: by 2002:a37:f619:: with SMTP id y25mr14291485qkj.201.1638477545592;
 Thu, 02 Dec 2021 12:39:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638381245.git.reinette.chatre@intel.com> <94d8d631-5345-66c4-52a3-941e52500f84@intel.com>
In-Reply-To: <94d8d631-5345-66c4-52a3-941e52500f84@intel.com>
From:   Nathaniel McCallum <nathaniel@profian.com>
Date:   Thu, 2 Dec 2021 15:38:55 -0500
Message-ID: <CAHAy0tQr17mhpHskr4Mr+ooGyxjbSqy02Z2UA27U7=Ew6MW2Rg@mail.gmail.com>
Subject: Re: [PATCH 00/25] x86/sgx and selftests/sgx: Support SGX2
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 1:30 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/1/21 11:22 AM, Reinette Chatre wrote:
> > * Support modifying permissions of regular enclave pages belonging to an
> >   initialized enclave. New permissions are not allowed to exceed the
> >   originally vetted permissions. Modifying permissions is accomplished
> >   with a new ioctl SGX_IOC_PAGE_MODP.
>
> It's probably also worth noting that this effectively punts on the issue
> of how to allow enclaves to relax the permissions on pages, like taking
> a page from R=>RW, or R=>RX.  RX isn't allowed unless the page was
> *added* originally with RX or RWX.
>
> Since dynamically added pages start with initial RW permissions, they
> can *never* be RX or RWX since they did not start with execute
> permissions.  That's a limitation, of course, but it's one that can be
> dealt with separately from this set.
>
> Does that sound sane to everyone?

We (Enarx) need arbitrary permission modifications. But for now we can
just use this patch series and patch the original permissions to be
RWX on all new pages. I think that should be sufficient.
