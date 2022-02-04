Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6972F4A931A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 05:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356971AbiBDEaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 23:30:02 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:39932 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiBDE36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 23:29:58 -0500
Received: by mail-qv1-f46.google.com with SMTP id k4so4444524qvt.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 20:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeXBm/rfxhK57TM4Y43wxxJNMsmmMyghZ4AqBNU1W8M=;
        b=VjSuqiMtjo9rUvFwgHWCKP6uFUx+IfuPpxE7ENNWfJmDOL4pwPTisTIzX5KSSkoNHS
         6KIUo3nCmzjpg12X8JlWQ+bS0DhlvpSUZz2ftjMRCHKURAMgPumyXLBdQg1+599xP67i
         a+jsBXD/ELWi0ihSJlSXDg3wAbbYpgCxTlep9RcYY+vMTq8hAyCD1vjQvko3genO28mh
         QUwwCONyB2KGtDlOTs/l5eenep3krLEGdkVrCgtcksP+D8loqDfPc2wnDgBlOH4qvRb7
         EhABteltGuFUIGQ+xP4lDdRfd2ubYrN01rY2318eybMsCALL/mCvOI5t1TAxalJ3QFfq
         vI7A==
X-Gm-Message-State: AOAM532YyJuDRVnQBebk76uWbS3JLc03iVPibBDTC7l+kXhfZ0rFuSpv
        0CSwMEipc9moYrDhKqbSxod9+zaInWfQNXcn2RunjpRimRatiA==
X-Google-Smtp-Source: ABdhPJzTT8GUOSjAF5jm4VDw+1Nrx2+ODxiu3FlVSnPQsVPz6e4uRTPBvySgPJ+lxc4y72AcnX6MsnuhJzFcZ78fVSw=
X-Received: by 2002:a05:6214:21ac:: with SMTP id t12mr691864qvc.123.1643948997789;
 Thu, 03 Feb 2022 20:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20220131051558.77127-1-morgan@kernel.org> <d3fc9d9-d99e-a5ab-10a4-7cc60c97e1e@namei.org>
In-Reply-To: <d3fc9d9-d99e-a5ab-10a4-7cc60c97e1e@namei.org>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Thu, 3 Feb 2022 20:29:47 -0800
Message-ID: <CALQRfL6ij=Hr44W_0Kwq+buWuinBB-JJAQtGi80CZkLT0D=Q7w@mail.gmail.com>
Subject: Re: [PATCH] proc: add SecBits field to /proc/<PID>/status
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

I'm not sure how to address this concern. Is there a specific issue
like the characters used in the newly added line are problematic in
some way? (I think '.' is the only character introduced by this change
that I don't currently find in, say, /proc/1/status, but if I create a
file called foo.bin and execute it, its status file contains that
character.)

In a more general sense, how might this change be problematic in a way
that, say fe719888344cc (from 2020-12-15) which added the line
"SpeculationIndirectBranch:\t..."  was not of similar concern? I've
tried to be consistent with the formatting etc. Am I missing
something?

Thanks

Andrew


On Thu, Feb 3, 2022 at 9:45 AM James Morris <jmorris@namei.org> wrote:
>
> On Sun, 30 Jan 2022, Andrew G. Morgan wrote:
>
> > Securebits strongly influence the way Capabilities work for a process,
> > make them visible in the proc status files.
>
> My concern is that this might break some existing userspace code which
> parses the status file.
>
>
> --
> James Morris
> <jmorris@namei.org>
>
