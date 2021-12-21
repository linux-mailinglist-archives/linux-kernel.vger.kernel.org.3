Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D50F47BF15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhLULoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:44:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233650AbhLULom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640087082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbwxDN6wj5FeFXwr7pjnR/9gTyWUAmPUku3aTqaGEOY=;
        b=X2TP4WtkKa239W7YhyP5LLaheIUVb7TCj3K4Abci7pKIN/wmlBmHP/mjozmh9BIpOpidAC
        Zy1fTvX3ZXizMjO1wPMOzcibVbKAxg3rNd6rzs3RIxYohAQk4fYOBQugHzboXL+7gwLtLv
        tEZJNFbcGag5WfV7o8jCKTRb5f0BxtA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-FXhi4RSuN6G4jj_YUY-SKg-1; Tue, 21 Dec 2021 06:44:41 -0500
X-MC-Unique: FXhi4RSuN6G4jj_YUY-SKg-1
Received: by mail-wr1-f69.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so4589877wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbwxDN6wj5FeFXwr7pjnR/9gTyWUAmPUku3aTqaGEOY=;
        b=kzQaSFdT8Lv85laH017iKVVTpZsV8Wq6bzs/ptcv9giZ+wQkw+31bnfOkI8NYg9CIW
         aVlVKjag6UV/+czYWb5E5kZQh6cXYWvCpiB2jbohfm8LlsGj0rXBXa+WHql/4h+eioPL
         UHTs6Efx7vD8T39DZSNbVUR+T5lQC4MV3K218xq964HxLuf7dX4VX/GL/XR5VqRdn6eG
         0BKPLAm3DLBYykfvE/Rixk4Sf2p/DQSYCBcJvJtHv9jxxnghyv6/wqj8or5RZu8za+/O
         s5AMCCHiEq27kzSU4TCwYTTTqS9V+GSdh52+QOQ8rR0xQW5HNvWKfg2fR+OG5r5lp4Ab
         KowQ==
X-Gm-Message-State: AOAM533zgyD0uMlK9CTAjAF0HXEYzVouwE3HlomU/Gqq4aSUh5PsSIps
        DcIGJC2q1kO1UJBHw1d5gswp0TaJj5vJdQky1SPK7wyCie2mhamxnohl65rxlTLl8xv51b/DqoS
        sRmQ3k+FpXhn40QN068oSWGo=
X-Received: by 2002:a05:6000:1688:: with SMTP id y8mr2226116wrd.682.1640087079994;
        Tue, 21 Dec 2021 03:44:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/jkUzjPboutyA7ZKw6bugiCMhEIJ/J5UCT3C0AchPv48wFvUEdKBJxeBkwaNlPk1TKH7zOg==
X-Received: by 2002:a05:6000:1688:: with SMTP id y8mr2226106wrd.682.1640087079786;
        Tue, 21 Dec 2021 03:44:39 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n9sm2318886wmq.37.2021.12.21.03.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 03:44:39 -0800 (PST)
Date:   Tue, 21 Dec 2021 11:44:38 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Allen <allen.lkml@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com
Subject: Re: [RFC PATCH] module: Introduce module unload taint tracking
Message-ID: <20211221114438.lbbnte2f7u6xi5ii@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20211124173327.3878177-1-atomlin@redhat.com>
 <YbEZ4HgSYQEPuRmS@bombadil.infradead.org>
 <20211209153131.a54fdfbci4qnyy6h@ava.usersys.com>
 <CAOMdWSKzH2uzD6XDN21x_R7_iThBko75s9tHTTMKxbG2pdFYMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOMdWSKzH2uzD6XDN21x_R7_iThBko75s9tHTTMKxbG2pdFYMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-12-13 18:30 +0530, Allen wrote:
> Aaron, Luis,

Hi Allen

> I have some ideas and did some work on it. Let me know if we could work
> together on this.

Yes, we can. What have you done so far?

Kind regards,

-- 
Aaron Tomlin

