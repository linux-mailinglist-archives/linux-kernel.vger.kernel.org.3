Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AAE4B5602
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiBNQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:22:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiBNQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:22:34 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2050B23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:22:27 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i6so28174342pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ltEJ7E4BWBQeXlg11/N0m4ls8Uk/IhOuIbuZYCef4Qk=;
        b=IXmjpqau+DaUR/5xQSJGBnkGUyDaCitlnAoCP3aF8lTStpgwVxYilTXncL/kk/aROW
         SmajbmzKXfv+U0XxvLy111mpLRySzoDwmruZdONpLJKAaEfB0hjkHgY4QpiKy/zyAyIr
         FDQyHIKG8w38flcPpgHGYMYLkhU7ija6z7p3sMKbfIhW4kFura3GYysQqMIaS4Br0pGv
         rS7i0csbsfLWD1NevfD9c++WYw13XEwwsELBU2x3wpNfd7m4A5wZgI+kj75sy3KZAiHt
         5dKg/wXmyAWNGOTql45RoP2t/iCfWY/kNh3fxJ8KCxBr5CTqvue0DfoG+QQiozJZ9CjO
         fdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ltEJ7E4BWBQeXlg11/N0m4ls8Uk/IhOuIbuZYCef4Qk=;
        b=7N7dg1e2Sr8bEDJsKMxP8N84U0l4Jg75llR2u1ETn0DLH2Rm7EyJagS7pV07Wyr0WV
         OtSjJ0jCCsytxzwm3qQy3arILyOhX/OHwUiKgzpnTmI0LNvvjJWOo2acbdvp97BugbhY
         QXvS/aOe030jpzNBsLMIYIwG4t0y6HGGXt1etEXwgMO5aAQm+0Ph8heYGJs99ovnZOHH
         uWmI4t2qZD6gvyBjUMuofuMS1k9kIZCGTdl2Ve5HbMZP6KdxUlPtjehQfuDVH+eXTL0V
         vdRnS32iOEG8qXTs5gs+GdcyELehKmGXd2H5HHSmWAbaK7BKGx2mc9LX5g60fZ6RoCGs
         dx3Q==
X-Gm-Message-State: AOAM532jAwzPbPH0Cxoz+8aqt2UjfTMz+CIGfMutekeVSXY+bpoh+Hdw
        eZ1xHfqkrwWpHGf2WAW0op0=
X-Google-Smtp-Source: ABdhPJx5fzzD/gdf+c0lSFQS4625i0HpoCk4kU0YkSEqVRkJQinMEReQOI9dMaggVFYmtGsRLGDCgQ==
X-Received: by 2002:a63:68c1:: with SMTP id d184mr386604pgc.405.1644855746806;
        Mon, 14 Feb 2022 08:22:26 -0800 (PST)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.xiaomi.com ([43.224.245.244])
        by smtp.gmail.com with ESMTPSA id x23sm37294540pfh.216.2022.02.14.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:22:26 -0800 (PST)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     longman@redhat.com, gregkh@linuxfoundation.org
Cc:     dave@stgolabs.net, hdanton@sina.com, linux-kernel@vger.kernel.org,
        mazhenhua@xiaomi.com, mingo@redhat.com, peterz@infradead.org,
        quic_aiquny@quicinc.com, will@kernel.org
Subject: Re:[PATCH v5] locking/rwsem: Make handoff bit handling more consistent
Date:   Tue, 15 Feb 2022 00:22:18 +0800
Message-Id: <20220214162218.13930-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211116012912.723980-1-longman@redhat.com>
References: <20211116012912.723980-1-longman@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hi Waiman, Greg,
>> This patch has been merged in branch linux-5.16.y.
>> Can we take it to the linux-5.10.y LTS version?

>What is "this patch"?

commit d257cc8cb8d5355ffc43a96bab94db7b5a324803 ("locking/rwsem: Make handoff bit handling more consistent")

thanks,
