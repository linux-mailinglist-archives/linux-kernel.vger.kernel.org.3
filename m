Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961F9465220
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351175AbhLAP4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351186AbhLAP4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:56:18 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD2BC061758
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:52:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z8so49067573ljz.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mx5dsdfz5OCSLF2KexsR17z+OQVCcJktBVTzMjmEoJ8=;
        b=pexgAzRgXY/1geXePlsTBZDrzBDu1p2gRtnq2cRAfzBigxzIRbaII3NH13sBhkLIee
         /nFW/nNnG9+OMmAxicgRbZFlKD2OV7cYVtEU2o1q4gT7TsuTO2+ooiICqsSJJJ0rJV7G
         xB0agkG8fYIRXG6gvbc9if22pm9BgEZEo/ypoWkUr7z5662IqhIdZB5qqVhHIsE60s0/
         RpRRuCQdkd+3Fm81SDwxk0BahKKEH8QM05C+Awzy9IT4GfS3OnlxwDvD2FMXNMsIlqPx
         Ab/b63eleqMsZzTomJZ/RQ9pknKr72R+bJ/Z04b00bqCZX/E27c4YzIyEgMxp66HfSNz
         dxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mx5dsdfz5OCSLF2KexsR17z+OQVCcJktBVTzMjmEoJ8=;
        b=xmYPjw8KX4Ynfuuvox8a3KPcpM9sxXZ/qEDOAkATM+deadIAMZ9upzbv6wuROKcsIH
         ZDemP92ierFRx5PxfS4skWeiWp9bUmge0mtPr9cfJ2vcqA1OYTFoeZ7C3FSq3QFa26hJ
         QGiQNAEvZmTgQEzkzr0KlP4zuOeHpEOmRSmEU68iHapMaiE7iJk6R45yRY87hGjQYkv1
         /hd55OjZJs+zw3gfFYHhsDIWv8De1HH2jkPYNM42qA9tDa7MJAzC1Vr9p+fj7sAi3cL4
         GLhA+mcOmV7w5o0623F0tatfCEVhvudNgtowb9g1Uc7hTTlkM9vPxROlpi6OLFm/AKDH
         6WqA==
X-Gm-Message-State: AOAM531v2rKyGLgySW1dO1cT6+lMh3B1wwjiQAFLaN6eZOvw+wRG6ioh
        dFXQvD9W4vnR267TLLwKjM1KNNA5NDW011BnHW8pOw==
X-Google-Smtp-Source: ABdhPJyQQe0BOvRpWo1wHLFVy65HP5wS2wZVjEw+auOl6P3ynLiLkdMNzIgQDrp1SMsIPpe3icDwQCYfW2jHpS+lgvs=
X-Received: by 2002:a05:651c:1035:: with SMTP id w21mr6160729ljm.278.1638373974799;
 Wed, 01 Dec 2021 07:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20211123005036.2954379-1-pbonzini@redhat.com> <20211123005036.2954379-2-pbonzini@redhat.com>
In-Reply-To: <20211123005036.2954379-2-pbonzini@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 1 Dec 2021 08:52:43 -0700
Message-ID: <CAMkAt6qOuXX1NCe=wwVXP7CeWdUiPQ0cdJr21jQn=h5pyEkpSA@mail.gmail.com>
Subject: Re: [PATCH 01/12] selftests: fix check for circular KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 5:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM leaves the source VM in a dead state,
> so migrating back to the original source VM fails the ioctl.  Adjust
> the test.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Gonda <pgonda@google.com>
