Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E51C4646E8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbhLAFzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346811AbhLAFzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:55:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:51:54 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v19so16803572plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 21:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=3+ix4WtXMbVX75afq6yOl61urhycIARKwGpxkJcu71c=;
        b=E94DBNzFDb3yOB7dm0HwlSaMqilM/31xhqbDk0nRfqRiJY2XnPo+aWqJDBEKycOwSt
         ipY6JM7jMSDsYY/PEy5GEyR+Ym+3TqeNoGZw36GfizaM/Xdn3lcd+3jLYkJuzb03tH1F
         54GS6JZcQX+r5maqMZJoivM3xK6WzNv7rErNWBjzlV+g4JojQZ5V2SBda1HHeFYOtX2W
         q3gat3zFEf7eJh1ZCnTevGyKOeWd7oIGcWaRetcj1kohDU50t3MZNTT2JSeM0tmySPuv
         V2TjbUy2w92EO0aJunmnR9fi3beIeuKURY9zNFmFzTRsJ/1gUd5Zcjm5ysIMJpLQ47BP
         BtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=3+ix4WtXMbVX75afq6yOl61urhycIARKwGpxkJcu71c=;
        b=OGl3l0Og6qa/iUveXZ2iXA9u41zDDiS8meUKY9orcj/Yg7t1stKKnv3QmERdW7+RSR
         Ii234+mE0vl/WX0uJ4HdVyzeAL8d4YUpg+P7Jdu4FJVDvNHnZ/FiyVIhHiqatJzxW0Cf
         tsplU+3/HxMU5Snr2eFmbCLsFzfH9j1NVzPFCaPb5Bqk/NHizxtfMk5pXOdTkYJeuf8H
         X/6vj1rrkJnHgxFNxXa7oT98iALceD+uf76ddxjNRoA730d39lcvu8EFRccwZtVPolkp
         Nmq6RigyVR9fssoYcSoHlwQS97PD5Cr6hJQB5VzFW3F57CrFjwttoDEnuSreGBpxiMtX
         8KAQ==
X-Gm-Message-State: AOAM531Jg2Dl9oGeyQHbh5vn9OvRhs7IFjBOEsckWezZcZPykhihJ1k+
        BYH5plv0Tp2P8NHQgo45kqs=
X-Google-Smtp-Source: ABdhPJyBTLs29i3Nm0ZJQZf1rzLsZ/eEHdXJ5WxAgvONI2yxO4BZXAe8UGGxpDdVwTfh3Xkms1V28w==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr4810661pjb.49.1638337913937;
        Tue, 30 Nov 2021 21:51:53 -0800 (PST)
Received: from localhost (115-64-213-93.static.tpgi.com.au. [115.64.213.93])
        by smtp.gmail.com with ESMTPSA id q11sm23262253pfk.192.2021.11.30.21.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 21:51:53 -0800 (PST)
Date:   Wed, 01 Dec 2021 15:51:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 rebased 4/9] powerpc/mm: Remove asm/slice.h
To:     alex@ghiti.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1637862579.git.christophe.leroy@csgroup.eu>
        <8ba40287876c2d6fe806b130f8c83b874f2469bb.1637862579.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8ba40287876c2d6fe806b130f8c83b874f2469bb.1637862579.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1638337883.bumneai7t0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of November 26, 2021 3:52 am:
> Move necessary stuff in asm/book3s/64/slice.h and
> remove asm/slice.h

Any reason to make this separate from patch 1?

Thanks,
Nick
