Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72E74A93B8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243525AbiBDFqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:46:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234466AbiBDFqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643953581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3Xf1wPMD3j9dFO1xFqh1/jT1YBoslpaP5CAcxEPhntI=;
        b=ZbsRKu7NoJ+y/x5p4CuI0PnusPUzpvJkWwUP6TTygL7tvjTNXf+X9QPEYO5LQ6KQzlpJdZ
        qQ1x7R4yoU7Z1kfA1n9GpZS5duY9AZS2Ua+mavoa51PnVbANuJyEpMPO9ewOND4BrxsKaz
        ELvTsuDerzBTEmCOoLsXBcQypHVGRA4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-N0F-6gbHPyeHcwvJKJod7Q-1; Fri, 04 Feb 2022 00:46:20 -0500
X-MC-Unique: N0F-6gbHPyeHcwvJKJod7Q-1
Received: by mail-oo1-f70.google.com with SMTP id r12-20020a4aea8c000000b002fd5bc5d365so2618533ooh.18
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3Xf1wPMD3j9dFO1xFqh1/jT1YBoslpaP5CAcxEPhntI=;
        b=0g0+oMZB0o7XWeIaoa9N2rhnl3RJhCzDir4eh5tijkSqyPItItAn0HLkFtwQTn7RT0
         CN4VwzW97pa9nRw2vhS7SpEaBD9dQxBZWJH9tJQ/PZZh9vadxoLJ0Tw0+Rr25XB3e1i7
         UWILZzYQshLmgmWJAMsszXOJnFjq/Hlr09YA15FfUxgFrz/eo7FYa7JLbAZeuneTcILV
         HQwtyD8SJk+3ChKn5n95L0WfuH0mA9P2jwSmnCK9J6IT4qNvSqcQmRyLD1rVDveInfaQ
         vExrtaI5z9479YC9e9uY6acDJYvkZaMLkAlzJi2igZAv96i/xMFBO5EdK2MBBrd/5ZXi
         2p5g==
X-Gm-Message-State: AOAM531yAeWkGZiU4wtmZjnlBOm3RgavDtbMAhnKxoaFBShqOKLSR6O0
        PsCl0KPOAWTToY+fcV3n0o/LzLBwucF8pX3vzUfXxCJNZmvz4lLkNUBkYGZpQuYzo0I2WXgVZNi
        JXEl4qIR8Sem6qTIex3EKFEkg
X-Received: by 2002:a9d:2e8:: with SMTP id 95mr574050otl.355.1643953579684;
        Thu, 03 Feb 2022 21:46:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUwP7giNT5XCbnIuwBRLx6jg5b86uE4BZegIhZJiJLYk5qAL65ZYmPsINZ+DINFWXIJ0xqlA==
X-Received: by 2002:a9d:2e8:: with SMTP id 95mr574048otl.355.1643953579448;
        Thu, 03 Feb 2022 21:46:19 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c21sm403878oto.55.2022.02.03.21.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 21:46:18 -0800 (PST)
Date:   Thu, 3 Feb 2022 21:46:16 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: iommu non-strict mode for arm64
Message-ID: <20220204054616.cfqhygo3v7amrzvp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We've gotten significant slowdowns on arm64 with 4k pages compared to
64k.  The slowdowns can be alleviated by setting iommu.strict=0 or
iommu.passthrough=1.

Is there a reason x86 defaults to lazy iommu, while arm64 does not?  Are
there security implications which are specific to arm64?

-- 
Josh

