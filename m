Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C74ADC44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379538AbiBHPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352926AbiBHPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62BB4C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644333537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1dLWDlmAylsVAbFh6dRuuTZBM7U6UZUvU1LhCTc2yU=;
        b=flUpgXq44x+f0mO57dp4hx5VDlip8gCZc7xvHd9CWpfA7WktHMqBxJZWMX4JfRx/SUYF6R
        UFax4CY7E1Fyd/bYHsjjn75ZcwvjR3eL8IOf+7moQnfZjlZEbKbXPEC6lZYQ7myVV+x+Y8
        rN9fEfqoqPKXwdC3N+rp6YiujSBl4fs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-I9bifseCM4KMxFAxU_QPrg-1; Tue, 08 Feb 2022 10:18:56 -0500
X-MC-Unique: I9bifseCM4KMxFAxU_QPrg-1
Received: by mail-wr1-f71.google.com with SMTP id g6-20020adfbc86000000b001a2d62be244so6178791wrh.23
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1dLWDlmAylsVAbFh6dRuuTZBM7U6UZUvU1LhCTc2yU=;
        b=wZL2ve2OYvnw+KGRIOhG3SOMBxLTTgis/bA9zm8BA8wkIc5X8zSQ6Th++pEbU+ztzq
         ty0taWBLoe1VBBIZSHdlyF7F47nBaqw2iMghcIZf8AjOHyKWoWW4xy+EGvbTeUCG0zH5
         aoohJAklzOsDXonNmvtwQHh5DO04eaCQm4mtXTbN/oWkJyeN3Rfnl0/aoZEc4iDqZ9pc
         +AiWV276GGaoCIbiENE1SxKj3VhSo4lbClReDqt+HS94u7tY3aLWAuYoFe3JGRDW3EOR
         tWcp5rVtU0nxZWn2AV+/C0Gs+PKBFrMiS5uu81vH643/o/aWx0xg8QvRgFBzIMjoPBTq
         WNMw==
X-Gm-Message-State: AOAM533XWuWe86QtKhxY3lSZcvhbx6JnUnbFnbEZfF9mJsUngJN9pWka
        uTxjcMWARLcXoEWY5GecNnhdIYfwDXahT9Qqh0ZI4P5sXK0pFA7wQJjGrWvRuV7I8Q/JfA3x/ox
        HPsmAcs1XCmXSASb/Y54qvgI=
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr1562110wmr.26.1644333535407;
        Tue, 08 Feb 2022 07:18:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlF2zSt7RYRFVBT770zFzAYkbM60g4+C9WVjw78vwP9vz+XHesCTBfEzpGpKZYFpy9H8xlRg==
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr1562097wmr.26.1644333535246;
        Tue, 08 Feb 2022 07:18:55 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f13sm2630160wmq.29.2022.02.08.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 07:18:54 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:18:53 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     mcgrof@kernel.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: Re: [RFC PATCH v4 03/13] module: Move livepatch support to a
 separate file
Message-ID: <20220208151853.avy4e7sgyutuempk@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220130213214.1042497-1-atomlin@redhat.com>
 <20220130213214.1042497-4-atomlin@redhat.com>
 <YgJXEhiwn5B4Psxa@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgJXEhiwn5B4Psxa@alley>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-08 12:42 +0100, Petr Mladek wrote:
> This should go to internal.h.
> 
> Alternative is to move both is_livepatch_module() and
> set_livepatch_module() into include/linux/livepatch.h.
> 
> I do not have strong opinion.

Hi Petr,

Firstly, thank you for your feedback.

In my opinion, I believe is_livepatch_module() should remain as it may
continue to be used externally i.e., outside of kernel/module/; albeit,
indeed set_livepatch_module() should be moved to kernel/module/internal.h
given its use is exclusive to core code.


Kind regards,

-- 
Aaron Tomlin

