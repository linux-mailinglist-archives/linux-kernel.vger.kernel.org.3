Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A518B49AC20
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiAYGCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiAYGAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:00:09 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A8C046E05
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:16:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d18so5251486plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iOG5WTBgZhfMtwYPCsNaOnc2/hv+YPjXSC9MURQ5W0Y=;
        b=LTo5hiH/Pog/i833Q2JQ6246B+bU+u2LZyUgtec45u/C2geW13mBw4rDEzgvXNcNB0
         WJ9mhPVw0watdJXd5EVtC8zeNLRXuJ1oRJ8bxfkFWcl9vYjKtG3rOkXkNPfN4LWxlKDY
         NyFF2F4CrThueMgwVVQqWwF+oyR7YXh5AIqOj+TGDIyQy3fnVsA2YdUOQhMLuinHmRNI
         mmafmt3VC2tYbSOuQUw01dDjCkIvarD5VYYAmcVjxP0LBhyGFIWRK4Z5DC4E+Q4rcoqb
         5EUmadf08eYvzdcf9g8RLmxJHZhwO3PiKW6YXWMPS3004EwZjvF9wcf5d9azNfETJDf2
         pZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iOG5WTBgZhfMtwYPCsNaOnc2/hv+YPjXSC9MURQ5W0Y=;
        b=JCmmRJaMTGsqS9Pe5ptQITWPkZu+0WSyEgRMrBfcCMyu8yRVwn/Pa2igazAwcfuutG
         RyAYtfVyGt0xVv1pKm1fth2yY7jTIFdPMK+AvvIJRhWvkNbYPKuIrwyq51kLIwPhs5Kv
         eWyEIWlwenRSrnEWZbpAmn1bQEyxBvrvaH7858jUTg7vMRASpglamVjibY0SXWbNsSJE
         Gqp0/htX9AKDrTJn6Tj873V8h3fozP5MhIXGw/is9ghBwJeyS8woQD5nz4vYqH0jk0tE
         IKFzyr3vI8LmOMo9NiblUJ1aaFNiO8bysmDk8ELP/yGTLeuhJBLh4TSW7ANgyDlKHqgF
         74oA==
X-Gm-Message-State: AOAM531MVjlxkBqSucKEwnFntzO8KwOdLxqwDQXwiR+7VEwA0Yy8L2tv
        P4D825KbNA9y89EqzD9X92G7KfbBYDZ0yA==
X-Google-Smtp-Source: ABdhPJxPvAZx1nrZK8RvCNQJxSEjXoxAv/EgUYt5goesLAsjzhw6VgxnXTVJxb3sp37j/6zUU/CYAw==
X-Received: by 2002:a17:90b:30c9:: with SMTP id hi9mr1669053pjb.68.1643084198823;
        Mon, 24 Jan 2022 20:16:38 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:5978:14f2:157f:f050])
        by smtp.gmail.com with ESMTPSA id f6sm4427901pfv.30.2022.01.24.20.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 20:16:38 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:16:36 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     "Dustin L. Howett" <dustin@howett.net>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] platform/chrome: cros-ec: detect the Framework Laptop
Message-ID: <Ye95pJiHfR3i9iwj@google.com>
References: <20220105031242.287751-1-dustin@howett.net>
 <20220105031242.287751-2-dustin@howett.net>
 <CALtnz62fQbyK+WEE=8zSQpuDuaVO=A6PTBEdrYJ+nrSuphpi7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALtnz62fQbyK+WEE=8zSQpuDuaVO=A6PTBEdrYJ+nrSuphpi7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:41:51AM +0800, Tzung-Bi Shih wrote:
> On Tue, Jan 25, 2022 at 9:35 AM Dustin L. Howett <dustin@howett.net> wrote:
> >
> > The Framework Laptop identifies itself in DMI with manufacturer
> > "Framework" and product "Laptop".
> >
> > Signed-off-by: Dustin L. Howett <dustin@howett.net>

Nit: "platform/chrome: cros_ec_lpc:" would be a better commit title prefix.

With that,
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
