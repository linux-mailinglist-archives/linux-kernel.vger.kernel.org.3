Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0416A4E19B5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244732AbiCTE7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 00:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiCTE7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 00:59:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA953D9E88;
        Sat, 19 Mar 2022 21:57:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so7835249pjb.5;
        Sat, 19 Mar 2022 21:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kNkV45zQuZkhTvGKZKcmhgk7SDSL/m3JRpXy/Hbo/hY=;
        b=NJ6zMfW0vPou6MY/aluF2UhRydg/ynbvdZopQI6ga+8acA5o8F/S3eQHTFc64CiYz7
         u2Ft4QwPyxyHO/jFXkxJpQEC/N43ALcVypjmE9AoV4YRdNkIAgE7P5l2FSzOw28ZcmeI
         Zu6fv7rqVsa587bZtrgg7dntvcbcbQAt1x8mpmFiNLiHTzu9u/+vg5riaunMOd1skV67
         E8oiD2SCW3YSMxM00V1NKFsgh7oUxQpOQmNmoSknXkEa8u+dg7xbI5e/oPR2qUfANpCm
         RPoT8O2/X+OEn9g7HT0ib6rXE6nlXwZJYBjhzo9LnYvNnApkObtGv/tniMnc6cZvltu2
         4xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kNkV45zQuZkhTvGKZKcmhgk7SDSL/m3JRpXy/Hbo/hY=;
        b=M2o25dFBX5txJL1VZMyRQZJ+IwVTaZlB7g1d2eYIjM7Tl2V8EnNXmk7WAHv/N9HS/A
         rkgUEz6K3JIahGYOnPyTQ8BlkS2E0seM0PFxeeAz/MV1axGwAlxkNWl6sP76jCxg35Po
         b4q+tz+T1J6Ok5u9nObdzuO1uq8f45n3e8bXUe3jS6r616Bsd8WDbPC+78sy2CR7j5jr
         Yx57BGhQiYB+yaMRf9BNlI0rB2u59Ayvf0Zfa5Y7xfz48t0+HCisvR+WFCUpT7VL3wVP
         6zZyev057kXN3Acc6crWajV/9NKLw/ARFaY3MDI+W4G0lFLLg9UAzYKsDEHmwG7sA/v0
         0lWQ==
X-Gm-Message-State: AOAM530qbVcuYaJzhoi+g0ASQhJwamtS6z6xPxtbKPdvHmemURD0Njpn
        qfjeRQ3MlqN/WJHO0K9dT6E=
X-Google-Smtp-Source: ABdhPJwvJ7MDBx0sEa1mEix0SkkTBNtIT1cCiMLYIyVYU4+sc8PRvuW2sAVMBLY1oTO58ZrBgKa30g==
X-Received: by 2002:a17:903:32c7:b0:154:19dd:fd43 with SMTP id i7-20020a17090332c700b0015419ddfd43mr7250905plr.150.1647752263405;
        Sat, 19 Mar 2022 21:57:43 -0700 (PDT)
Received: from localhost.localdomain ([36.24.165.243])
        by smtp.googlemail.com with ESMTPSA id k5-20020aa788c5000000b004f7a02d2724sm15112075pff.50.2022.03.19.21.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 21:57:42 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jakobkoschel@gmail.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, beanhuo@micron.com,
        bvanassche@acm.org, daejun7.park@samsung.com, jejb@linux.ibm.com,
        keosung.park@samsung.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        xiam0nd.tong@gmail.com
Subject: Re: [PATCH] ufs: remove an unneed NULL check on list iterator
Date:   Sun, 20 Mar 2022 12:57:34 +0800
Message-Id: <20220320045734.14087-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6EEE0ACC-6F7F-4D29-AA2B-751E4677B35E@gmail.com>
References: <6EEE0ACC-6F7F-4D29-AA2B-751E4677B35E@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2022 01:57:39 +0100, Jakob Koschel <jakobkoschel@gmail.com> wrote:
> Maybe it make more sense to move that check after the loop body instead
> of removing it completely? This code obviously does nothing in it's current
> state but it's clear what the original intention was, so restoring that would
> perhaps be better.
> 
> But probably someone with more experience about this code can make the call
> 

This seems like a better choice, if it doesn't go against the author's original
intention. I will fix it in PATCH v2, thanks.

--
Xiaomeng Tong
