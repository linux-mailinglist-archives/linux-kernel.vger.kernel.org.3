Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DD50BDD4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245718AbiDVRGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbiDVRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:05:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040636E4FD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:03:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h12so8481187plf.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BoHm2K3ZMTehK9sE+U91LQiGPglplAVwfUXYnba9qeA=;
        b=L3IJIn/qXd/KXkwirNMP8HaT8Q9z9d8+YMaDAWecKR8U0MfGRKZ+zTMpM9HaF2OLtP
         0kgfllgtQ48Rwhq2CLzSo78zG14g5LwHAtXRBJuJcG7qO2PEdrpIzhrkwYiGBQvnTxIc
         HTlUkG/wT85cyKKuZksAgMJgOUdg3iqTJOogYvYreDOHha34fy5ScWJfbCfsgXuIb/rY
         sXgcf1F8PFuIEuvJtWbcm+dPZyv7zC1jhAbK6KROnEqjFQJDIDXa/uE8W08qHG+YO1EY
         JfgC8Ik5tagHuw0QOhQ/uigxF2KxSYmPUdVe15roXc/CiATcX3xWtXT9FBo5YPwN/jrf
         Iw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BoHm2K3ZMTehK9sE+U91LQiGPglplAVwfUXYnba9qeA=;
        b=t387I6L/jlMs6MVc/NmI87ycZrGLMjcEVj+lHnC7N3LjzcKsKKe/7lHex8rC9pJY4R
         /pzXvHz6CBoz80CzaRYUF0KN1zsfEDtypZUvAbhgNnIoCm/JwnBDqpdmxC/OOsNhCJUq
         5JEa6HPKDPtGY0urhCA0vuMIZVPzKBZAYwTsvzOZeMJKKgHqkgOIgDRjnZrLNQy+9Udq
         GgafaZ4MiLhZC77D+MhiIZV3k9UZASvsLf7yxKxpx6c4+Doc+E70HJyI8G6BjAgfHqhN
         I700a5HtqtzZuy1ZbFqmqCUMLG3Q6OdjCw+S9660BAwPzPcZvtRK/ZAT8LLWM0UgfJIA
         OSTQ==
X-Gm-Message-State: AOAM533fA3cix8Ndgxte0XMHsubWhEtbKuhAKSVlcf30EgPfsKkEzyXx
        1wf1tACtqwulhF0x6iKPbN8=
X-Google-Smtp-Source: ABdhPJxzTUjtn5abJlDmPMtyx6gxMLoD7MkBm0R4JyPyWsVfwTKfSQwma61sk0HCUTlLxxhOoue4EQ==
X-Received: by 2002:a17:90a:fc8a:b0:1d8:ace3:70bc with SMTP id ci10-20020a17090afc8a00b001d8ace370bcmr2526988pjb.37.1650646982338;
        Fri, 22 Apr 2022 10:03:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id h14-20020a63384e000000b00366ba5335e7sm2603673pgn.72.2022.04.22.10.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:03:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 07:03:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] kernfs: Remove reference counting for
 kernfs_open_node.
Message-ID: <YmLfxHcekrr89IFl@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410023719.1752460-1-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Imran.

I took a look to patch 5 and it looks like there's still some work left to
do. Maybe it'd be easier to concentrate on the first two parts - the notify
list conversion and open_file_mutex conversion first and then get to the
rest later?

Thanks.

-- 
tejun
