Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE056B7F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbiGHLEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbiGHLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:03:59 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640242A95A;
        Fri,  8 Jul 2022 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1657278238;
  x=1688814238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hVRYG3p50qnDjZtNI+vfDnB95JRUiYZHlJYn4fjg5XI=;
  b=oLf7m50dZHcCbEkrUM1CNHA52EB+8+aZG9yXBlytJ1xCmRukEr4H1F6Q
   Buj6VynI+8iwtjP3aVljzBN0QejvLnrx/Epooyzw0ejUkby/VD29PJxyw
   OJmEPej4M0r/GrBnbfCuAxVTHwUQ6IKokoZNqjOSmhcNpyqDIXh+07O1V
   1ZJN+pFZM+UE/QD5aujiOQS9SYN9w0D7iSREUUhFrWznK7eieVPhv0TQA
   fQRMW1dJaEXbd0HxV7s5SKCP6mJGkGxEYbVd0f7AhCF1HRkNxUKH56NoC
   /vpUx+p366asFk2Dqrrnf5Zk+fovrHWZAh24u/7ycd5KBLC/xsqq3j7PD
   Q==;
Date:   Fri, 8 Jul 2022 13:03:26 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Oliver Neukum <oneukum@suse.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: PM runtime_error handling missing in many drivers?
Message-ID: <20220708110325.GA5307@axis.com>
References: <20220620144231.GA23345@axis.com>
 <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5caa944f-c841-6f74-8e43-a278b2b93b06@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:38:33AM +0200, Oliver Neukum wrote:
> On 20.06.22 16:42, Vincent Whitchurch wrote:
> > [110778.050000][   T27] rpm_resume: 0-0009 flags-4 cnt-1  dep-0  auto-1 p-0 irq-0 child-0
> > [110778.050000][   T27] rpm_return_int: rpm_resume+0x24d/0x11d0:0-0009 ret=-22
> > 
> > The following patch fixes the issue on vcnl4000, but is this the right in the
> > fix?  And, unless I'm missing something, there are dozens of drivers
> > with the same problem.
> 
> Yes. The point of pm_runtime_resume_and_get() is to remove the need
> for handling errors when the resume fails. So I fail to see why a
> permanent record of a failure makes sense for this API.

I don't understand it either.

> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index e02e92bc2928..082b8969fe2f 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -414,6 +414,8 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
> >  
> >  	if (on) {
> >  		ret = pm_runtime_resume_and_get(dev);
> > +		if (ret)
> > +			pm_runtime_set_suspended(dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(dev);
> >  		ret = pm_runtime_put_autosuspend(dev);
> 
> If you need to add this to every driver, you can just as well add it to
> pm_runtime_resume_and_get() to avoid the duplication.

Yes, the documentation says that the error should be cleared, but it's
unclear why the driver is expected to do it.  From the documentation it
looks the driver is supposed to choose between pm_runtime_set_active()
and pm_runtime_set_suspended() to clear the error, but how/why is this
choice supposed to be made in the driver when the driver doesn't know
more than the framework about the status of the device?

Perhaps Rafael can shed some light on this.

> But I am afraid we need to ask a deeper question. Is there a point
> in recording failures to resume? The error code is reported back.
> If a driver wishes to act upon it, it can. The core really only
> uses the result to block new PM operations.
> But nobody requests a resume unless it is necessary. Thus I fail
> to see the point of checking this flag in resume as opposed to
> suspend. If we fail, we fail, why not retry? It seems to me that the
> record should be used only during runtime suspend.

I guess this is also a question for Rafael.

Even if the error recording is removed from runtime_resume and only done
on suspend failures, all these drivers still have the problem of not
clearing the error, since the next resume will fail if that is not done.

> And as an immediate band aid, some errors like ENOMEM should
> never be recorded.
