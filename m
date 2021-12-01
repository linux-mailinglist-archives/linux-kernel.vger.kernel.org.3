Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326E34647BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347137AbhLAHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhLAHSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:18:13 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A60C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:14:52 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x7so17310952pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=1uk8AY7N4MyV3vrrUtytqYnsAZsCNDVB9MP5ky8h6A8=;
        b=RXdXhI+CvCxSdPUTuKENnUmX4XHZq16mtkPYQvPHgW9jqxhOqg1ozrPR/9YBPNAGmu
         IBSgWopcck53DtnwZJEi86cf24CM2kbSQqMol5oi10QFxFjktWohXHDQjaxYmmhELrSY
         6SFVby0hgIQQ8w4jU5uC/6aJiPa3wQIZSS0hlljbV/teu600S04In2aF5Cr6hRy+loUD
         8Fky0Hdmnp7HeWSci/0/QXLKyNPqV3KPb67pYeWXpryX5GTejKy7fCLe+VrFZDDeZndz
         6n0gh18wbTawpZUg0fKFaswU4HtrZBXMtyWwB4XADIBWX0dzo6+gr+logh8yEfPYAwyy
         i1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=1uk8AY7N4MyV3vrrUtytqYnsAZsCNDVB9MP5ky8h6A8=;
        b=4+Jjk56NxjPxO8uVwCSgO0G6GTnLnGIG+LX+xnCdd1apNwzFPtS+d1N0kddlxKKZ3U
         wzSMTfzP1t4ERemqmz9tuBZn+2JY7TFO2OWliUYnKS5Q0O42pNWKuOAxhM53pB+aCR8q
         Pfpj5lhBwfBYzN6MhJPPpAXhzyq9Ml2g/9GEYEN01WZIVEekBBUEW7tDkdwMumFqhtTW
         sRAo6wzp5QyAlF5wfh2cP4iCZc+dI1MOOu0Qh5QamogBm1h/v5HxZaoasFyVFFqttq8p
         Q7H5XDphNxKvoKvFs948PPyTKHySbi2kaFfPcuUjPQbdcB8M/rfCmJzqZ7mfVzmJqOVj
         t4Uw==
X-Gm-Message-State: AOAM532V7j4cniAy8lst5+zTY3ds/tzVFOQ0HKoPvtxEFivLk1nM0tY0
        VvtSeEI3HOR54jhshcerp3c=
X-Google-Smtp-Source: ABdhPJziC1xL2lk1pMDy78fJ8PMONfyQIQXcj7mXhNpJJunHKIUUjZaZa7g6LJ4WyWe54/XFM+XY6Q==
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr5291791pjb.113.1638342892541;
        Tue, 30 Nov 2021 23:14:52 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id pf15sm116019pjb.40.2021.11.30.23.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 23:14:51 -0800 (PST)
Message-ID: <61a720eb.1c69fb81.80210.02b6@mx.google.com>
X-Google-Original-Message-ID: <20211201071450.GA323284@cgel.zte@gmail.com>
Date:   Wed, 1 Dec 2021 07:14:50 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dbueso@suse.de, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: Re: [PATCH V2] ipc: add set_ownership() and permissions() callbacks
 for posix mqueue sysctl
References: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
 <20210827101206.5810-1-ran.xiaokai@zte.com.cn>
 <20210913144047.4v5jquhyysnnlfvh@wittgenstein>
 <6142a2ac.1c69fb81.6dcc6.61f8@mx.google.com>
 <20211004105313.k55766idkyoo6jvt@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004105313.k55766idkyoo6jvt@wittgenstein>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 12:53:13PM +0200, Christian Brauner wrote:
> On Thu, Sep 16, 2021 at 01:49:31AM +0000, CGEL wrote:
> > esOn Mon, Sep 13, 2021 at 04:40:47PM +0200, Christian Brauner wrote:
> > > On Fri, Aug 27, 2021 at 03:12:06AM -0700, CGEL wrote:
> > > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > > > 
> > > > When a non-root user process creates a user namespace and ipc namespace
> > > > with command "unshare -Ur -i", and map the root user inside
> > > > the user namesapce to the global owner of user namespace.
> > > > The newly created user namespace OWNS the ipc namespace,
> > > > So the root user inside the user namespace should have full access
> > > > rights to the ipc namespace resources and should be writable to
> > > > the ipc mqueue sysctls.
> > > > 
> > > > v2:
> > > >   - update commit msg.
> > > >   - fix the coding style issue.
> > > > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > > > ---
> > > 
> > > David,
> > > 
> > > are you happy with this too? If so I'd pick this up.
> > > 
> > 
> > Hi Christian,
> > 
> > Is there a xx-next branch for this kind patch?
> > We will try to fixes other issues like this, so we could tag the follow-up
> > patches with the branch name.
> 
> Hm, sorry that message slipped through the pre-mid-and post-conference
> cracks.  I'll added the patches now for testing. See:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.fixes
> 
> Christian

Hi Christian,

How the the testing goes on? 
