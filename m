Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4254E25D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347048AbiCUL7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345896AbiCUL7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:59:09 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6149C15B07D;
        Mon, 21 Mar 2022 04:57:32 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id gh15so6630201qvb.8;
        Mon, 21 Mar 2022 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGIwRa3FcC2veOls//vnX+YOmatILFcNzd8+dnQrnzU=;
        b=bcOKssJof9v1EZ4ojQb0oapk0wlHmg6od+QJ9oqIE+DY2FS4ix3TxD+jpd7+xKzDwn
         Ja0G3dV09hKBYxvUY6jMbY74VUMlJ+NzyKOl3+refyIWLpSDjYZbruk/07GVe+1NNaQu
         EyuhNHHgy6uUez6OvF8j4bUpUMN4oJTd213hm4+edgtYAU5bJrUqLuutK6Twe4vc0VKJ
         kRkvoMrmMiomL5IqzytGHjf1SDD1OqBpfxoQpq/J1XJxSbzpif1xFDKLnjcA7nWM7b8R
         MZwKoJC4oiuXQcJRb1wyjIyvTmy2tpPC4yv+1C+0tri5+yiF2VtnO6aeMtblq43wZ5Qc
         OwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGIwRa3FcC2veOls//vnX+YOmatILFcNzd8+dnQrnzU=;
        b=Bayo3M+Yk24mwm5RSdSY63bt6AhxFLBH2KG/kXkgwIJ/AdUCHXVCk2+nNjA3i+cDao
         iRy7Dguf7GTtr0t79PexeS0l8afXMNAIx21XRWxhoL0KBYND4zncBoYHkqeS8d+nTcOM
         O9ZOjgU1kIk9QsqbimFvxUdpNnxLZRElj+hqjJHZ07LOaBu4ZDduc1DEI9lIZFyWKlxa
         d/2ujuE5w88fByExZHUTmtwhSkC/QENvnjfPMb9HN3obC4eWS7ya6OwoSp2ZcSNVDk2b
         iW+9EL1msyk3nxE9bhPet4UJeUk7av61JGnv/c9HPVctg/k00QRUil2Qjf0ii9gDPI1g
         txdw==
X-Gm-Message-State: AOAM531VLuVc6u9UvMG41sZ6XLGpeDox6ycmtEiVWnMIr6oCdIxuICf8
        2lpejFCVp1MgPm90IQRh4rjDRwsFcc7VBtQMMwM=
X-Google-Smtp-Source: ABdhPJzTt2NY5A4S7KLCgQ9QSNIqObNNWBN/Z5yI35spdYZbfQd4pV49kthYZEHCXSz+Qa5abuRmYkQ4aFOr3EsSLuU=
X-Received: by 2002:a05:6214:1cc2:b0:435:1c62:62cc with SMTP id
 g2-20020a0562141cc200b004351c6262ccmr15758217qvd.26.1647863851445; Mon, 21
 Mar 2022 04:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220321053815.71316-1-schspa@gmail.com> <87a6dj3b5c.fsf@jogness.linutronix.de>
In-Reply-To: <87a6dj3b5c.fsf@jogness.linutronix.de>
From:   Shi Schspa <schspa@gmail.com>
Date:   Mon, 21 Mar 2022 19:57:19 +0800
Message-ID: <CAMA88TpV6p4wRhx1dpRf7V2Oc27FzV_HR7mb70oGn83RGnfF-w@mail.gmail.com>
Subject: Re: [PATCH 5.10-rt] printk: fix suppressed message print when reboot/panic
To:     John Ogness <john.ogness@linutronix.de>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de
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

John Ogness <john.ogness@linutronix.de> writes:

> On 2022-03-21, Schspa Shi <schspa@gmail.com> wrote:
>> Update printk_seq for suppressed message.
>>
>> Affects 5.9-rt and 5.10-rt
>>
>> When message is suppressed, printk_seq should be updated, otherwise
>> this message will be printed when reboot. This problem was introduced
>> in commit 3edc0c85d154 ("printk: Rebase on top of new ring buffer").
>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
>
> Nice catch. Thanks.
>
> 5.15-rt also has this issue, although the fix is slightly different. For
> 5.15-rt, writing to con->printk_seq (via latched_seq_write()) requires
> the console locked. Would you like to post a patch for 5.15-rt as well,
> or would you like me to do it?
>

I have upload a new patch for 5.15-rt, please review it too.
Message-Id: <20220321111501.68241-1-schspa@gmail.com>

> 5.16 and beyond does not have this issue.
>
> John Ogness

BRs

Schspa Shi
