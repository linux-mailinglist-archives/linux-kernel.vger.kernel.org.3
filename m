Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A41947A25F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhLSVdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbhLSVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:33:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C24C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xAFGlmLNuslYD0bVcZZJndq1PW70WwzhN6gshG9X/f8=; b=oWeV7NgBCs1q6TagMNg+vrYcUt
        cQsrtqc4g9iRMwbVMDotaLcf9PePnVONQtgyrp0Qw9WUjN13I4Cs1e+u2AAF/+J59JwErc1T7hKta
        2y/nlTe05ruKMqLgVKujGMde+7ocKIr/FGO1igx1ODgN5hCrrXuTC8BC0ffHoB0DhyLFa+3vwK8Ka
        icMHNEEZWEsFte5e56Iv65RFLRwnKvXR6oah3LdU6xtCjqLpMamqIVGWbz2NhRDfvfTIVHnx85lCB
        nlfqOWnWv5TXV+4+Rp5Q1A9p1X9Z/BEDiHXMd5OOzpUlgpEoiGTGzUl5MtHBlmjZLxPIfxknxicIT
        xm1fKA/A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz3nd-00H5iS-RG; Sun, 19 Dec 2021 21:32:57 +0000
Date:   Sun, 19 Dec 2021 13:32:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, keescook@chromium.org, jlayton@kernel.org,
        bfields@fieldses.org, yzaikin@google.com, apw@canonical.com,
        joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        julia.lawall@inria.fr, akpm@linux-foundation.org,
        wangle6@huawei.com
Subject: Re: [PATCH v3] sysctl: Add a group of macro functions to initcall
 the sysctl table of each feature
Message-ID: <Yb+lCVrP3eGfKjE+@bombadil.infradead.org>
References: <20211210085849.66169-1-nixiaoming@huawei.com>
 <20211213033119.51263-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213033119.51263-1-nixiaoming@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:31:19AM +0800, Xiaoming Ni wrote:
> To avoid duplicated code, add a set of macro functions to initialize the
> sysctl table for each feature.
> 
> The system initialization process is as follows:

See Eric's comments, we don't need to take care here on order as if the
path does not exist, it will be created. So please updates the commit to
to instead reflect that reality as I was just lazy and assumed the worst
and was just being cautious. If you get to add a few tests on
lib/test_sysctl.c and tools/testing/selftests/sysctl/sysctl.sh  to
verify it would be great too.

  Luis
