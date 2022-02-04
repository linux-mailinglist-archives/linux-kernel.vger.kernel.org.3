Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF53C4AA0FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiBDUOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiBDUOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:14:02 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954FBC061714;
        Fri,  4 Feb 2022 12:14:01 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w5so5822933ilo.2;
        Fri, 04 Feb 2022 12:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2uXHEXxkIh5tNExzXTu5EghPbGd7VDbfe3S2Sv7xCc=;
        b=fnLJ3lfCBhZWjwvbFgIkfsnyiL9ktZvZDrWLyTqF3ZlucU8LzhWoOtmwbNZITEid4U
         9ldVb6EmipGN53PSf1D/W8NXm9x87zkxKWiYUAAG9brTVP9jSAmNdr5YUYQbFGbRl2BM
         lvZcYrJe0iVo+8xvm6Oji5QFQiQoyqsPjKZCv8HkBU2/T6PhZFcMWw3J74py4cS22rnC
         YFIwwzIFtR104G/qyLpCOGU2Pc/91QtLF1dHzApyGW4Goo0ulOY7HcZUg0HY4bpOa/bS
         7Zl9TpY8DzVl4PuoyYYhIdjrcJzikzgMyTpW9NA0iHWm0grsdBai8suk9qS5rlj0Q77b
         hHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2uXHEXxkIh5tNExzXTu5EghPbGd7VDbfe3S2Sv7xCc=;
        b=S1Csc6xaOwDmDzKkHh79qaBHisTJwu4h9zipda7J/Ezd90M/PY4i+ZPw1zljoH/qBn
         xlYg74GrZ+oECk/Sj5V1DrgPF2oaQ4TDvkzczVdaACSimapK5XdOkT2PsLi+FyqquYAP
         cJoW34XQHB8cgFKC1PQvQ2igHueSfvrRyr9RktxOAiXMJgChr45RUQ+vGQ4Dn5F1j9Rc
         FPb0pIjSePa2wYfakAcsbh2QugW3CL6Vx87TYf0HFGKJQ7YxGrn5L1hukcmE8vGftMDO
         wNCesavxXR7fA+lU2BqOkfoh5kUAAMTrRAflUPGlWGUuzrKU99iGVAn5MBEyGSmFBBUO
         ASMQ==
X-Gm-Message-State: AOAM533D7tUOCeriBPlNV19X5/QtrO65PAAFPA3wQksLKduI31+VBU4q
        +BiuhzOz0RWg+25sqQVzO7nYxf3OXhMKlS/MyAv7dHRN7CoV4w==
X-Google-Smtp-Source: ABdhPJzl9oRSx3T2VGieg1N4jpSkaB52LiEiGAAxb3wWJxSk4dNYztmtGp1NEkhbIHkLkzXPgvA59lxt2TZxsONUwe4=
X-Received: by 2002:a05:6e02:19c5:: with SMTP id r5mr423289ill.164.1644005641067;
 Fri, 04 Feb 2022 12:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net> <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
 <8022383.T7Z3S40VBb@natalenko.name> <13a9d0fd-1b2c-b9c1-24a7-ff4fc5f4b8cc@roeck-us.net>
 <CAB95QATUK+q01TLuubqR9D1fLJM=C6VjxpabnkseQRUvsd-9YA@mail.gmail.com>
 <20220203222310.6a025c5d@netbook-debian> <CAB95QAT2iZexNF__dwJQHWoeFACcCMPGFGQQyF_9weATkfeJ+A@mail.gmail.com>
In-Reply-To: <CAB95QAT2iZexNF__dwJQHWoeFACcCMPGFGQQyF_9weATkfeJ+A@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Fri, 4 Feb 2022 21:13:49 +0100
Message-ID: <CAB95QASd5QLBUvkKLKW3_b-L4qKEAKarHTuk_5PtcoubSGTitg@mail.gmail.com>
Subject: Re: [ASUS EC Sensors v8 0/3]
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What about other B550/X570 boards?
My previous reply is incorrect, in fact we already have information
for some of them, it is just me who can't remember or distinguish
those board names.

> We have such candidates with same WMI methods in nct6775:
>         "ROG STRIX B550-A GAMING",
No data.

>         "ROG STRIX B550-E GAMING",
Already included.

>         "ROG STRIX B550-F GAMING",
No data, the X570-F differs significantly from X570-E, maybe this one
is not like other B550 models too.

>         "ROG STRIX B550-F GAMING (WI-FI)",
Probably is identical to the non-wifi model.

>         "ROG STRIX B550-I GAMING",
Already included.

Best regards,
Eugene
