Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3674147C859
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhLUUkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhLUUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:40:10 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93597C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:40:09 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g28so239988qkk.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 12:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CA9IWavU63XG2gXPf0Ek8dVYzF3SSJzma8mENQ8i0FI=;
        b=GUJqO5fkKd228TnOmKcYkuDCb4kQeaJrE/8O3rq5oOYr558k1XrQseIUEwv60oB53j
         MLNB3eWYdA3Ar5fU6Y7mG6IvL1lCtMbrKxFgsTXa99XwsErz8kr7gj8dGT37yfezNc2f
         PaNiUp+2F/WnpTVhKcxn7DGWrrR6WFpGQkflQaZ3NACVRfdw+ckC+OndqEFV49gdEgc6
         O7p5rMquNSl1YHyQwXbWeU+xhlRkCapl6goJ/8gWeE+cBH+m6NrBmv2RifibLrguZE9m
         w86TScRZR/y/NmI5iSfwUIPHPcBkhLA0XLmQtsgv3B0r6pMp9PCj8eziAIeBRs3lCr5o
         RW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CA9IWavU63XG2gXPf0Ek8dVYzF3SSJzma8mENQ8i0FI=;
        b=4r+HPrR0Jli8PP0MW5Y+/BesugtM9L26einRNZ4hibDeZ0rVZGZXc/SddiuhDBOTAE
         TWVUTN6EsKFht7zv+vKjADktM4ARUfQKMLv9GLdEJDDwmyJQmdqfrzhhyjskBG6VzS56
         W76WLKWLGGl2vX288ARbnASGFjRJWq4Pyv+L/QpGbWtICDsgUo4nFXQcwJnqvZliGG60
         2IqIeqYidtokGmc6QnuGi+yiACwYVhbs6bvhyBap2YCaBoPkdVnBRu5LP5VNI/zhkeTy
         FsWqD3J+z30dBzIj6Gib7pYb1rTg+NVaoKv5MEeZ6p0/9rBQ90D17+1rAAYopD4xz8Ql
         5J3A==
X-Gm-Message-State: AOAM530AEPIMFPfCS/guglQZ7ofLT0/M8Fh0dXKEXiGCXli2GIOP0pO+
        DCmvI0BBhQJ2AZ6VoVv8/Gw=
X-Google-Smtp-Source: ABdhPJw0wRHZas/LCq2WLTm8mLs8VsVYgQgbhBLolRHcZrEdPydvbZvbiU/KzDQWHRpUBOc9rzwwww==
X-Received: by 2002:a37:a956:: with SMTP id s83mr84812qke.500.1640119208810;
        Tue, 21 Dec 2021 12:40:08 -0800 (PST)
Received: from debianG ([190.191.20.243])
        by smtp.gmail.com with ESMTPSA id w63sm41651qkd.88.2021.12.21.12.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 12:40:08 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:40:00 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: Re: [PATCH 0/4] staging: vc04_services: avoid the use of typedef for
 function pointers
Message-ID: <YcI7oGVjwQA4+5uc@debianG>
References: <cover.1639858361.git.gascoar@gmail.com>
 <YcFyNFR66Ii2tos+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcFyNFR66Ii2tos+@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 07:20:36AM +0100, Greg KH wrote:
> On Mon, Dec 20, 2021 at 06:29:10PM -0300, Gaston Gonzalez wrote:
> > This patch set removes some typedefs for function pointers in vc04_services.
> > 
> > After patches 01 to 03, there are no remaining typedef under vc04_services.
> > Hence, the patch 04/04 updates the TODO file removing the 'remove typedefs'
> > task.
> > 
> > Gaston Gonzalez (4):
> >   staging: bcm2835-audio: replace function typedefs with equivalent
> >     declaration
> >   staging: vc04_services: replace function typedef with equivalent
> >     declaration
> >   staging: vc04_services: avoid the use of typedef for function pointers
> >   staging: vc04_services: update TODO file
> 
> These are not the name of the patches that you sent out at all :(
> 
> Are you sure you created this properly?
> 
> Something went wrong.
> 
> greg k-h

Hi Greg,

I'm sorry, I messed up editing the subjects using git send-email
directly. I didn't realized that that would create a mismatch with the
summary in patch 0/4. It is clear now ...

thanks,

Gaston
