Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE97D570D19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiGKWC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiGKWC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:02:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD71509F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:02:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id os14so11123405ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrQHGenAPcBlC/ZOhdo6i9KabzEHsXdSNH0n9w7BLdU=;
        b=eZSQQnl6YAyy5Y7Go0SjjoBnWLk0i63J8CTBP6ef/0CGLJnNRS3Ub0XxnW+RZsVwAJ
         ssSJwm5mdn04w0+hKyAvU8vBs9rjTgWsgMzztK805Ma/ZeRQpR6G/qm44mCuTe5xcGld
         uWOmQScH3KtBchIXztn9Mms62sszPmhnPMWow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrQHGenAPcBlC/ZOhdo6i9KabzEHsXdSNH0n9w7BLdU=;
        b=Qnets5DiW9f8c6uj1RiuW+9E0Ru9xGlJPLKinjp8OdF+TZdodmYqMiFlEg+tpE2PJC
         LAgkwdJ+XnO7zUPs0ca6T2evbEFV/p/Q5XpW/hz7Q56SWo7XR/6JSmMVVS33hoboCWuL
         yUG4iMEhB7wlrwUWSAKrW1iBmHDtrTNDKDE6/sbZNqr5/LtBDqqgSNaCSSgQzCsrCoST
         GkApglOSWmlZg0MeXXTp/etwukwnJgkKmAUBiKTl1Ju+1rmSI89ZMaFUCk9xoyu6RnPa
         zes1gU3VZrs6Zh3jJjnUmX7sM+pKe6oV2Emvw6CkzDGxCHn9s3bXPIMqjZaDEPVZeRAC
         Q1fw==
X-Gm-Message-State: AJIora/agjmdfjQ90U8uUAXm7Pu1+0VJUUtWJVuYKP99kzRWddbFrgHn
        L2Scogbzk93VvcD3/kdRlis/qtSuctUaB/us
X-Google-Smtp-Source: AGRyM1vqGyByQlYVUxMGYfXCNK2cUf1wo0lRzKsi3LwxzLG5l+g6lrwb0koXf0/B9DwNFxvanucHkg==
X-Received: by 2002:a17:907:6e92:b0:726:c846:591c with SMTP id sh18-20020a1709076e9200b00726c846591cmr20300597ejc.428.1657576944959;
        Mon, 11 Jul 2022 15:02:24 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id ov16-20020a170906fc1000b0070759e37183sm3111125ejb.59.2022.07.11.15.02.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 15:02:23 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id q9so8725158wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:02:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr17894808wrb.442.1657576942811; Mon, 11
 Jul 2022 15:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <87a69fct75.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a69fct75.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jul 2022 15:02:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wge5Dh6ukEQoueSh9dzn6GPqGiRtDQqfSnP5vWEXKJzXw@mail.gmail.com>
Message-ID: <CAHk-=wge5Dh6ukEQoueSh9dzn6GPqGiRtDQqfSnP5vWEXKJzXw@mail.gmail.com>
Subject: Re: [GIT PULL] ipc: Fix free mq_sysctls when ipc namespace creation fails
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 1:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the free-mq_sysctls-for-v5.19 tag from the git tree:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git free-mq_sysctls-for-v5.19

The pr-tracker-bot doesn't seem to understand octopus merges, so this
one didn't get a pr-tracker-bot response despite being merged.

I don't do octopus merges very often, but since I had done the ptrace
fix as a hotfix for rc6 and your other pull request thus didn't bring
in any new code (just a new commit), I did your two pull requests as
one single merge:

  23458ac91dc8 ("Merge tags 'free-mq_sysctls-for-v5.19' and
'ptrace_unfreeze_fix-for-v5.19' of
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace").

just FYI.

            Linus
