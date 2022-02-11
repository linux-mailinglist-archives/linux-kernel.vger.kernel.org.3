Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F784B2EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353433AbiBKU4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBKU4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B59E;
        Fri, 11 Feb 2022 12:56:12 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cf2so18176764edb.9;
        Fri, 11 Feb 2022 12:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tgv7ys2zhrW+e9PNgo8siOn8/16+4IpioSAv02Oc+pc=;
        b=SGKgygnDcuydKQNXbAIAgtRCWdEnfQlF9CLEP9e6blfzdYaBrvvQPYnvveYkBTsY9x
         zwitWArfsEx/f0tNRYkf/fcKCQ/vV36NKqYw6nE/93GyZcIH8G+h/P28pNU74IDGeWbL
         sIFxjm7sjdEEUtC/28AKRpEmPr8rkDdOV+0gY3REEIh776vbIWXYhBw3Rm8XFGeYN6XG
         +YNALzF8qdQCsEqCNO/xmdslyWBRmViAwvYwDg+O6+fndpsgULQjcFzHq52qq4YtGNqd
         pN0PYM5wrmIABdwGW3uZeivWEE6m0y3vxvoKU929A6H82nZgowbt0X3Sb19OXIzxnQv8
         hBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tgv7ys2zhrW+e9PNgo8siOn8/16+4IpioSAv02Oc+pc=;
        b=R88n/OCSZRJtwQDKdNeBQS3kuMps/KBH8C7pOutJMeJm9fnu7HNgezjbK81DGF74TG
         8Bilzzh/JXn6FsxBzuWQR/7zSu3hoYIXNX7oG4rrB/uElrVwNM1PdyF3EtDVm6xoSeiQ
         oljOXuf/CkfW3+55qFKKzbHj/sQFrRXlxRqKbNfCpwr9dGcGZLJkX107/SafqXXQY4tn
         F0UUf7f/aadwEQJqmSsOkiXg06sOGrSdH6Gs9tT1W0wmDJPam3l6h5TXH8+cDQjp18CC
         EpFpFKS8LYZE4NFWPFJCI5M/avQnJmxBLkE4J6FZjBv0MuVfGXb7Bu2CD/pUKgvzKdch
         C1WQ==
X-Gm-Message-State: AOAM532ZpfdJrs0XMinaZREp5Pi4purRYEF8fZPDOtEO+vDCKrz1RbQ8
        3wpNtzwslNsBoGkDjMYdNBWIlP5YQvARky+fRDg=
X-Google-Smtp-Source: ABdhPJydyDt3+X5VIrTpx3PQtQy02bTuF2uAvgGMZN91i8Gglb3c6XTZvHHha46M4FOtfhkw/fqNSmsN6xZNrW8VX9Q=
X-Received: by 2002:a05:6402:3492:: with SMTP id v18mr3902168edc.345.1644612971455;
 Fri, 11 Feb 2022 12:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20220210225222.260069-1-shy828301@gmail.com> <YgYCdhgQ+PoudJvv@infradead.org>
In-Reply-To: <YgYCdhgQ+PoudJvv@infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 11 Feb 2022 12:55:58 -0800
Message-ID: <CAHbLzkoF6JenubW_p0sO-_GZ6repeOm7euZKq0kG+UvcZWw6Mw@mail.gmail.com>
Subject: Re: [v8 PATCH] block: introduce block_rq_error tracepoint
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:30 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thank you!
