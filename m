Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2720E58F99A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiHKI5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiHKI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:57:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50984915CB;
        Thu, 11 Aug 2022 01:57:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so32370715ejc.7;
        Thu, 11 Aug 2022 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GIdfx5iQy+A2DaHJNThxqBSnLUKgCDXbbKynfdxrqiM=;
        b=X1xDw/uh1XUAYFy3mb8Id8swYy6nYRTh87F8Vgp7GFbMqUet/PmYAIUSmRdeDROQUO
         S2m3ZhB6KafFUdePobAP7De/XFb+wP9UjI1Lg0VhmBcc+NywoNdkMO74KAP7tjva8idy
         WkY8TsK74uaau7g6nDHgDJ6TRTTcGzEAi8Qm/RQ+Ez+fCtTcZT4L7ZumK74siwwxlZb1
         q2ELLHY3Hh2EmnIUZOPvPwxfA167SrzgHkzEK1S/QOJ1blgEYcAZreddQjMZTH6FEbEf
         vWcuCxQRuYbFIQ9giPSa5tRdP2VzIKwtf7YJuwnkTD4sY5ibHDyQQ02OU9DMgcbxUTKM
         kE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GIdfx5iQy+A2DaHJNThxqBSnLUKgCDXbbKynfdxrqiM=;
        b=auQQzIc+GlU0oDQV57a4WVIWurLJ1XtIuJFsrfdScE80S/ySQpNCA5IdlXza2L13K2
         2uDMmTBin98WiGFAQIJIZBAgkPvJZGcVuglkzDYHqJfh8e5pxnSRPlcBiNnVMutY3rNM
         NH18TZJETyVUHqRjXmK7aUutCX7BvPho2UXsItcx+E3TT9fc8174dxqs71UrMK2Rrz5X
         GGX6JuTn/1DeYcIWuK8syl+5VSeJioWd3I491RcDiHQKRpYHwqexiQrCt6igBUFZz+VQ
         JGyNs2yebYDkIgEnEso6O+VfIj0gitb/atNEvO1Pebky6ydT3aeKkNjEzCcy8vlK4Oc5
         kDHQ==
X-Gm-Message-State: ACgBeo3UhdfRiJrRiaIDCZ//PcuQKysv4tHmuwKu/0+7ZjB49Vbin+du
        ud4wN0rszn/Lh1lUJmlBrz/2LMdi2wpFuDvdm86FL4lpYNk=
X-Google-Smtp-Source: AA6agR6flTDJLRGrlqd+EwYfrdtb23mJTMpAnsxHTjlX31u87fAqIzGn6+9Eobc+Lldi15nlwleMb5Qsq8pTIBnEF9s=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr24056669ejy.708.1660208256904; Thu, 11
 Aug 2022 01:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220811025346.113199-1-dzm91@hust.edu.cn> <20220811025346.113199-2-dzm91@hust.edu.cn>
 <e959ac7c-7e74-b84c-ffff-ea0069634eb4@omp.ru>
In-Reply-To: <e959ac7c-7e74-b84c-ffff-ea0069634eb4@omp.ru>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 11 Aug 2022 16:57:10 +0800
Message-ID: <CAD-N9QWwz6RaQ5-E5XiWGHOmHZUABYuQVuKY_7ThgQGpNFNwcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] USB: ncevibrator: simplify tv_probe
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 4:34 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Hello!
>
>    Your subject is broken now. :-)

Yes, thanks for your reminder. Will send a v2 patch.

>
> MBR, Sergey
