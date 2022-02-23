Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8C4C0B95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiBWFSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiBWFSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:18:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E5966C8E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:18:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d28so9838158wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0BgigNUrNvplvAukfXfrovtiwMmzb+y5eO45fKBV6E=;
        b=g2zccOH7ylqr4PUi2B42mMTqWAZRAuQKQ2Hh3/SobWWAQCZs6layh8kvpP4KOS2BhH
         mxfthf1CYVxJKkj/n1Rrj3iN6ZTHerNah+Oc5LrTlO0NT34dZa5TDxdVPQYHVFbJEZII
         CQVagn9OtQuhNmGnTxKAWUCGwIhnFObmFEFcnEszONYFPkfNquzsYT1khtOsh53TIyQW
         Op3DQgUDiJXsBsBSar7QV/LnEZK8cg6RiATUMtwZrBlxMFAhAwKb/z8oEp1MNNufH/Ti
         UfzRKKA/hVBUswDDEbXnaLSeoSqjwIs0t5+lfpxMrTclw0aQZ6avkTHRZOtWe8Yd4KTB
         v7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0BgigNUrNvplvAukfXfrovtiwMmzb+y5eO45fKBV6E=;
        b=eat9Cs5fwDVJMQBzCzHrUFSayp38ykHRvqkYi2Ui+/+12XvAnTXGvfzVpmp8tGmoBm
         76q3HLnvRK14zC+tc95LrmzdPq2u+El7chEw/jEvq7emzjVD5c2eLNLhS9GixbL6qT99
         IeIv7DYcpgbFRLNQ1gtR6yNaUP5QAYz010Au/ifpTzT3t+4rwqC/H7GxlrAgPi9u2gpt
         sVzE4koprWIK/tQx3ZrTTSmYS3MGJ267nr34SfmEW+f9IVTqudgHyKKTPRIvJY3FeAwq
         NuRF0ZD60wV+OJhbwakr9H9bP1DcTVcuTuqGtxdAff4IaCCiBRto6/TL+ZyvfY7WLxkv
         F0Ug==
X-Gm-Message-State: AOAM531zMLadwxaJ9jQZZSeNKYcqAXJqeEdoq83MTnd0MEf+R4i0Vqde
        9v3PzptwD6G81PdJwfKffQzc2K8W9pjw2PwP4cppGA==
X-Google-Smtp-Source: ABdhPJzy4RsYm2AifyKCzU32taS+CwXeaQzrPMUsKpWqayY7FOX66cwITzM7el7Petj4+mxg3d6Byp9ZoG97wQsVrJc=
X-Received: by 2002:adf:ec51:0:b0:1e3:d68:6398 with SMTP id
 w17-20020adfec51000000b001e30d686398mr21450737wrn.203.1645593484381; Tue, 22
 Feb 2022 21:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20220214165021.1.I89632f95e6af380102cdb1ec9f7a6d5cb948b029@changeid>
In-Reply-To: <20220214165021.1.I89632f95e6af380102cdb1ec9f7a6d5cb948b029@changeid>
From:   Pablo Ceballos <pceballos@google.com>
Date:   Tue, 22 Feb 2022 21:17:52 -0800
Message-ID: <CAO9JgFwwZ8u_rZgj5=cKiJ511kk6_nKgUF3S6a+rucr943VC0w@mail.gmail.com>
Subject: Re: [PATCH] HID: input: Handle OOC toggle switches mapped to keys
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 1:51 PM Pablo Ceballos <pceballos@google.com> wrote:
> I'm not sure if this is the best way to resolve this issue that's
> happening with the "Phone Mute" HID usage. Or if this approach will
> cause issues with other HID devices.

Further testing shows that this won't work. The problem with this
approach is that there is no way to know the initial state of the
toggle switch. Please ignore this patch.
