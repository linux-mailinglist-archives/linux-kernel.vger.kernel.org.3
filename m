Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A95473691
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhLMV3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbhLMV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:29:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NzKc+52kOTNB/nvRY8AH90XtwVx4tAfEtt2Kgck45jc=; b=ejQecJ8GtMjvJ3nrhp30ZpRx67
        rVD1A891gm3PqdTVV4VN336Wbvb45pSjMzjCn5KKR5LrUuu7m/7+P8cHnasa74d27Hn2LVsLNGpeg
        gn25D4NsjbsfFwgQ+YbqSlM1oeLaRtslP/h4WqBAMDMTzo9tbyXWtw8E1YkozPW3ykZoK8jBSVOPj
        7iHq3UsTah2Dhc739egkIwp4SupIH2xias3op/MMoeRkdmSAJxTo93isy/XQsFPKdEZw6lYqLGZwo
        /koU4mkRzqbVsjr9vZNO/nFB/83oyJ0UvWgJxefRdeY0/BEunF3HiPQJA2gXTL+fLgX6YBodyVKXX
        44qYeifA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwst0-00BTLp-IB; Mon, 13 Dec 2021 21:29:30 +0000
Date:   Mon, 13 Dec 2021 13:29:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
Message-ID: <Ybe7Ot8b/N4yy3TM@bombadil.infradead.org>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
 <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
 <Ya/BnndSXKHiUpGm@bombadil.infradead.org>
 <875ys0azt8.fsf@email.froward.int.ebiederm.org>
 <Ya/iv33Ud+KRt9E9@bombadil.infradead.org>
 <87mtl4ze1r.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtl4ze1r.fsf@email.froward.int.ebiederm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:04:48AM -0600, Eric W. Biederman wrote:
> If you look at __register_sysctl_table the core registration function
> you will see that all directory entries get reduced to simply a path
> component.  So they have nothing but their names as input into
> the sysctl subsystem.
> 
> Further __register_sysctl_table goes in a loop through the path
> and does get_subdir to find or create the directory.
> 
> Which means that if two places were to register sysctls in
> the "fs" directory they would both use the safe "fs" directory
> and whoever can first would create it.
> 
> Which should mean that worrying about ordering is completely
> unnecessary.
> 
> What am I missing?

I was being too cautious, sorry for not having dug enough.
Then this makes things much easier. Thanks!

  Luis
