Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27490513ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353135AbiD1XIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiD1XIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:08:12 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949BC4038
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:04:56 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e12so11598992ybc.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQoVU4wGr8TgkC2O9uwCdXrBPx5WfN6I+AR9CAalrvo=;
        b=XykUdOJn9AAYSBHln1orKxsbOypJXSbwjzhIzD7IcRnnYUvwgltYXHySy0heRgqmMs
         RJeuWmzbv5mDyJtwHeHvzgVx2pscUXPDMvmsltuzig803Y2YMfpVTBBFGLhrFZ3ILTah
         fAF9TVqjEer+q8Awbhb0o4M3GYJbKFdR57XYG6Xv8a+UNHO6HZd2HcIDnLL6kLb/G74C
         CxZOaFAx3/kBrbXhxTW0WIZ9UT8a3d7AKyQS//hiHH0DCajdMbHJ6Hn0HZt5TtLYnyZc
         q9igatKhJMUTY/BLf8VWNIVELubDkLv2AnnQDyJDaUPNSI9SGx+TgKZpnQaANKTEmDem
         eQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQoVU4wGr8TgkC2O9uwCdXrBPx5WfN6I+AR9CAalrvo=;
        b=N/xnZ6DbDdAejTTWG+0zgy7QqDeoLlu0Re9FwhbFddRWRmYq2YooWwL59/nZE/7hgK
         FRiFUawqpWpx02IC/xw5hK1Uh1j7FdQdXT7bmL//oT7kpWnTgWlPqIeMi+LKWPzonR16
         S5Qtt4CKZF9zsNet43pC7CukNwCnlQVO5YpNApzvkBiOOrfl8ZIUjxqQUQehx+SvZ8oC
         fDxGNf1IXaf9qmUOPgOS5ibMVphk11GAmsVOY2a9JPB7maEXZZT59MZ0IsXrGgV2wSI+
         98RK5x5qVnLz/HkMW5r+5RasizheR6N6PPiw6EbH684B1YNBSjmfbSrogzFCRDRVepXk
         rdxQ==
X-Gm-Message-State: AOAM533lQOmRhahq19aj86DjJDWThF7QHvFoobKBTBOdL5rXhrF1AxXH
        PdL6ExlXz4LW7/KNtquGWtPbxdgt08FDWTJ0kd2RirAy4Ek=
X-Google-Smtp-Source: ABdhPJzSp3c9446rYI1rmrmWRZfF6j7G2HNGTVGEVU7YcMlA3YZIIEkTWDv3eWMKgBdvG3xXWMpDUFcY5OeEHkIBbaM=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr33358655ybr.295.1651187095841; Thu, 28
 Apr 2022 16:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220425081416.22836-1-wupeng58@huawei.com>
In-Reply-To: <20220425081416.22836-1-wupeng58@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 01:04:44 +0200
Message-ID: <CACRpkdZt0aq36MAS5PWPZtiC6UQLkW1h8TBw2pmQj2xNzW-=eg@mail.gmail.com>
Subject: Re: [PATCH -next] ARM: versatile: Add missing of_node_put in dcscb_init
To:     Peng Wu <wupeng58@huawei.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com,
        wangxiongfeng2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:18 AM Peng Wu <wupeng58@huawei.com> wrote:

> The device_node pointer is returned by of_find_compatible_node
> with refcount incremented. We should use of_node_put() to avoid
> the refcount leak.
>
> Signed-off-by: Peng Wu <wupeng58@huawei.com>

I applied this on linux-next. signed off and sent directly to
the SoC tree.

Yours,
Linus Walleij
