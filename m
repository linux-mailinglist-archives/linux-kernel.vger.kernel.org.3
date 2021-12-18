Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1774799F4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhLRJfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhLRJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:34:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49ECC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 01:34:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639820097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsrFxZ7LghZCBD0q1TROqeQuviwCBXj8ZPRITfAMyZs=;
        b=lAZgR+uqs7/7BiNCxbRT29wK4ARs8kDgxPN2cKgHQYNPXEa44+/ftgv/GECn+DxdZnjX1S
        nmN8ai+CTn7LM2zPlTGvFSn7l3YP0HSYnbx+giXXL0sST2NYWC+xaSSpQHgVMvDvJcP6PJ
        qzcM7I29ZMnooPndG1J0hxYxYImbwQtqbWX25Zu3HvuwL1HwXl27r3kgnfE2oC0oF63miA
        V94QbiWxTBRLnmlQ6qp7s49waojiumqa69C39fj2XvGrxjCG3Cvru1L4nDxKcKmuR4dXvu
        44QWBzSFA6+eMAdIMYqVZv3UMYFok5yNStQM7FP8uEAmwGIjXw3Fsj1ZgJnD2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639820097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EsrFxZ7LghZCBD0q1TROqeQuviwCBXj8ZPRITfAMyZs=;
        b=yP+a258NAq9mxTFKpRdsZsCC5NCpwyjzqttMYG6vaNnd/L3esCpjKz7cdsjyR1jMkwVztp
        wrtnyhztPN4CCBAQ==
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: RE: [PATCH v2] locking/rtmutex: Fix incorrect spinning condition
In-Reply-To: <PH0PR11MB5880A552E7A3856D8F9165FBDA799@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211217074207.77425-1-qiang1.zhang@intel.com>
 <87k0g3ar7z.ffs@tglx>
 <PH0PR11MB5880A552E7A3856D8F9165FBDA799@PH0PR11MB5880.namprd11.prod.outlook.com>
Date:   Sat, 18 Dec 2021 10:34:56 +0100
Message-ID: <87zgoy9ry7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18 2021 at 07:24, Qiang1 Zhang wrote:
> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>=20
> Sent: 2021=E5=B9=B412=E6=9C=8818=E6=97=A5 4:53
> To: Zhang, Qiang1 <qiang1.zhang@intel.com>; peterz@infradead.org; mingo@r=
edhat.com; will@kernel.org; longman@redhat.com
> Cc: linux-kernel@vger.kernel.org; Zhang, Qiang1 <qiang1.zhang@intel.com>
> Subject: Re: [PATCH v2] locking/rtmutex: Fix incorrect spinning
> condition

Can you please fix your mail client to do proper replies without copying
the mail headers into the message?

>>Though this does not apply because the condition is incomplete. You
>>somehow dropped this from the condition:
>>
>>                   vcpu_is_preempted(task_cpu(owner)))=20
>>
>>Please make always sure that your patches apply against Linus tree
>>before sending them out.
>
> This commit c0bed69daf4b ("locking: Make owner_on_cpu() into <linux/sched=
.h>")
> make the following modifications in latest linux-next.
>
> +static inline bool owner_on_cpu(struct task_struct *owner)
> +{
> +       /*
> +        * As lock holder preemption issue, we both skip spinning if
> +        * task is not on cpu or its cpu is preempted
> +        */
> +       return owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
> +}
> +

Fine, but then please tell against which tree/branch the patch is.

Thanks,

        tglx
