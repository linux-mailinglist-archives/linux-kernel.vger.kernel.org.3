Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65AD47B3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhLTTwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhLTTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:52:35 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E81C061746
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:52:34 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y22so42988643edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1oPQByG1dXddo35PK/fKRHPs/4wTgR9C1zy9ObAU5c=;
        b=WIn0UTgjwlO691UxJ/DcCzKCF9ByVml9SfOH5F/O/a8lE1VZQwaEZGKjfPg4e1SIC2
         uYbqblsIFfS1dZFgjvEx5h5nRHFexPKwyUomg8F/tH0bo9YLdBtSSGeWVqKyC5rpuzd6
         q9b85HgsLR04aR63Jj2EjIaD118tCjGxzrH81+1B2lDpSV04XLmjRJxy6Sq5/xvMys6G
         fRNONIR8xRBdThDlwZpMMzpupyEY+t/h1xCH6uiwFNMhepvSvZ2c0nswa1hH7VonJoe4
         2j8jrXy1z2BY106TXbdcbNxhzKqyuN4wAFz8Lb1sEU4WCkCWT6BUfAYda7wi1DVW0xwK
         Hx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1oPQByG1dXddo35PK/fKRHPs/4wTgR9C1zy9ObAU5c=;
        b=A72GhpZbxwCFwV4fzqrU7ThWYyzRsmnayrL8gj6Wkwf53fBOGnA5OCiR1KtbnQcvNi
         nJgi+eJHn8SxXqqxsENKglYDfbe+bUFkQwhgooQtPOtNsZZIolD2v2dqJUaligkwQuSz
         RTTRTe9ZCf99K76jrgL1Waugp4WNtrrS4jR9LOCT8XTqpD63sJKGic6w1c/2CVcazF1W
         odYkH1tx1jvoDta8mdpuHWsExd3VU3d7U2n2rI2nAmXQe1V/jSZB6B8FJxGzYIIg7kMr
         lfE1UWVQlr1kjlMjE6gBeR+VNYrE4UmnMeOIxIreNW+r1Wt45rIx2r5Y7Yx8EQM0HdtX
         f2Jg==
X-Gm-Message-State: AOAM530Ue2s6kpiZiq8eUGbMJwDlEg/gej252K5qG9ltPoS8LC63FQVV
        P9ox1+DwN5mREDZTVAk3uYlwXHs89zfaWqk4d0KR
X-Google-Smtp-Source: ABdhPJzHH8WKbHiBR8J5N36EO1i/2gZu3g6U93gIsnl0hlyfs0Jq7GFl6MQohuYbdyqLvwnKlLRyOJwr9eEbho0RJqE=
X-Received: by 2002:a05:6402:424b:: with SMTP id g11mr17415028edb.6.1640029952994;
 Mon, 20 Dec 2021 11:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20211217010152.61796-1-xiujianfeng@huawei.com>
In-Reply-To: <20211217010152.61796-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Dec 2021 14:52:22 -0500
Message-ID: <CAHC9VhSAj08HSV4XKvRraK3v4PVSyh5jaLpNYxfOde5KJgsaQg@mail.gmail.com>
Subject: Re: [PATCH -next, v3 1/2] audit: use struct_size() helper in audit_[send|make]_reply()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     eparis@redhat.com, gustavoars@kernel.org, keescook@chromium.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 8:01 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Make use of struct_size() helper instead of an open-coded calculation.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/audit.c       | 2 +-
>  kernel/auditfilter.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into audit/next, thanks!

-- 
paul moore
www.paul-moore.com
