Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5654653DF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351871AbhLAR1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbhLAR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:27:36 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:24:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so18250090plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=riKKnm/gTzrvu3mmNy9r2Dx83vujiOgd6Un/alvFcEQ=;
        b=RDtAqABAnZGr24NANWdY7jGkw+9QKXIMGOjIM0nGEwiFJ9cUzZK8TaGN78qPR0kIpe
         E29/Wkm+QFCrLEfH33xKh0zB4QNjcxObjzfikIxeZf6kYXBRd5EHMxoOXdy1nBEnXg0c
         cuYq+8RG4RpYRD4ShAbT5U95AJ3KxleSl/sW1cbrL2R0gRY/qn1tQyx+QCelcAifYS2e
         KueE/T2Cxym1Lz1vgePAxQDFbhrAImNbTmd6BRNJS3F541p3jEEe6OVmYYxonOCRDyfn
         f1GQksSirIcMXyjnTSC1jerosrB8/OOUdrIJVl41otJ9ws1fiGaSk6lE+Z2FelvyHoP0
         u78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=riKKnm/gTzrvu3mmNy9r2Dx83vujiOgd6Un/alvFcEQ=;
        b=ADfIwsFDFxpY4ZlNrXNJjA+ZLOcdLzTfBgWvG5YlLVNAtyOwqM2sgcMTmZsM/xtAHs
         hcEQMkNkh1KlrRJndCEv4QI65f/nY4ouc811IL2CuntsXkLQz+eew+NDUM1lWhq1in52
         g7Q9xuiL3fJGkvMbHiUOZ0n5vSubtCNKpA751WsgYYLV7K3d6NRXBcHfA9A4IiN+xK+h
         QgIbrMEACQiDtxxm8oxQqPi5Ha8GEkn5CQka+M7Zo1zcQCv3ya1jTEjmcwE9IcqXyIxi
         TYaxRnEGOLmBUj9jgjP5M2QLLX9SeZIWETRj2mOW1uNH2AAC9A6mhbsdSA9jdCtS4xA+
         tIaQ==
X-Gm-Message-State: AOAM5303MDQ6l4GRL+EvDv+LXkr5K/IkUvI8+aZZn2qv4YUbfx7XCS/l
        I3qHXVwR/osJkXqKzHj+kZ4=
X-Google-Smtp-Source: ABdhPJxcYG3sgAaZSFfmeCmk+c1Gai/AF61KrL+bg/5Obz6U1TJgTgmaq+N4qioCCmGyvHC6+bie+w==
X-Received: by 2002:a17:902:9882:b0:143:91ca:ca6e with SMTP id s2-20020a170902988200b0014391caca6emr9178999plp.64.1638379454875;
        Wed, 01 Dec 2021 09:24:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h186sm405779pfg.59.2021.12.01.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 09:24:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 07:24:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] cgroup: Trace event cgroup id fields should be u64
Message-ID: <YaevvIJXxqxGyeXu@slm.duckdns.org>
References: <20211201165658.728107-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201165658.728107-1-william.kucharski@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 09:56:58AM -0700, William Kucharski wrote:
> Various trace event fields that store cgroup IDs were declared as
> ints, but cgroup_id(() returns a u64 and the structures and associated
> TP_printk() calls were not updated to reflect this.
> 
> Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>

Applied to cgroup/for-5.17.

Thanks.

-- 
tejun
