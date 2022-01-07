Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7953B487FC5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiAGX5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiAGX5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:57:05 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6199C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:57:04 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id v124so3201271oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gWsKJmsl21StJZ1rysNqz8IujBAzCpEKq2IQ6ebENWw=;
        b=iQIrH18CM2YLaNkK66Wne8rZXru3KwzCTAxXT/20i02mzeJmGaXq4jlA/0O5qy/oUW
         Fat2xOKRsNx50odTudxMHLki4Fq/kiKFcceqzEmhSsjC2W2QKcUe67wI2h9mSh/5H27V
         3wM6S/OwR/D1hLn3ZeSL/rNiRO2H22TyoLLCK8cHdkYUgBqOlY6qazQjFBN3LaKsGPsL
         BKQ8PyQynnCc17w/Ujevi9I3ek+9rr7fmADnw3IYfL31Ea6BKBA6vwprQxgNXzZ06gXR
         OTdnyM66KLq0zZfVTRJmIo5j1IedmPHAHlhClxYm+9+1nar51W729krnHnwMSntbvaOX
         USZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gWsKJmsl21StJZ1rysNqz8IujBAzCpEKq2IQ6ebENWw=;
        b=dZHWkUlxnXtbIj2oiKuOBsclQtgFyOFcMp4V5+gb0ClzdncI8QH4cUk3pTU44VjO5f
         SR44DGefdpROXPew36MDWPVng7uiuCpcQ3QaoBIjQ/fim0I1/pRqjwH7I6w7SpI7q9ej
         LfSNhFf7pZjGKxuLpukbAiKdnoAyvVBF0Ij4vemm3vmRQEfmB/xOCaqJCyLkcZ7udvXa
         8bnGgLev2hQ0x0TjEyfMJrnZ9Wxl7tAlYtibjiOEV2JBXYvMddx4ObSIr8fyZ0ix/m38
         fGmvfxeTe8S+ekZJDh0a92cXR/A2huHSZDminR3ZCNN/SaKBBbfNPjlsiJnPHpX84yNa
         4whg==
X-Gm-Message-State: AOAM531Bd0rOj1UVpie8GDVM9Qvj83FNLPVlzNhTmB9fkO8p798ErFBX
        VXUwB3vI/Dr26rMv2s9YFi+/7g==
X-Google-Smtp-Source: ABdhPJzY5t7YIPlPzi+AnQPaZqB1YJEEJWirxiXhVRU/uu8tXtyrSdDTrnRZXpxYaIDaw5qcwcuajg==
X-Received: by 2002:a05:6808:1521:: with SMTP id u33mr6297340oiw.4.1641599823988;
        Fri, 07 Jan 2022 15:57:03 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d3sm36203oiw.52.2022.01.07.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:57:03 -0800 (PST)
Date:   Fri, 7 Jan 2022 15:57:50 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rpmsg: char: Fix race between the release of
 rpmsg_ctrldev and cdev
Message-ID: <YdjTfr/sREITAGWB@ripper>
References: <20211208125220.v4.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
 <20211213173207.GB1396405@p14s>
 <YdiYOP9mhmWay/Ho@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdiYOP9mhmWay/Ho@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07 Jan 11:44 PST 2022, Matthias Kaehlcke wrote:

> On Mon, Dec 13, 2021 at 10:32:07AM -0700, Mathieu Poirier wrote:
> > On Wed, Dec 08, 2021 at 12:52:28PM -0800, Matthias Kaehlcke wrote:
> > > From: Sujit Kautkar <sujitka@chromium.org>
> > > 
> > > From: Sujit Kautkar <sujitka@chromium.org>
> > > 
> > > struct rpmsg_ctrldev contains a struct cdev. The current code frees
> > > the rpmsg_ctrldev struct in rpmsg_ctrldev_release_device(), but the
> > > cdev is a managed object, therefore its release is not predictable
> > > and the rpmsg_ctrldev could be freed before the cdev is entirely
> > > released, as in the backtrace below.
> > > 
> > > [   93.625603] ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x7c
> > > [   93.636115] WARNING: CPU: 0 PID: 12 at lib/debugobjects.c:488 debug_print_object+0x13c/0x1b0
> > > [   93.644799] Modules linked in: veth xt_cgroup xt_MASQUERADE rfcomm algif_hash algif_skcipher af_alg uinput ip6table_nat fuse uvcvideo videobuf2_vmalloc venus_enc venus_dec videobuf2_dma_contig hci_uart btandroid btqca snd_soc_rt5682_i2c bluetooth qcom_spmi_temp_alarm snd_soc_rt5682v
> > > [   93.715175] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G    B             5.4.163-lockdep #26
> > > [   93.723855] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> > > [   93.730055] Workqueue: events kobject_delayed_cleanup
> > > [   93.735271] pstate: 60c00009 (nZCv daif +PAN +UAO)
> > > [   93.740216] pc : debug_print_object+0x13c/0x1b0
> > > [   93.744890] lr : debug_print_object+0x13c/0x1b0
> > > [   93.749555] sp : ffffffacf5bc7940
> > > [   93.752978] x29: ffffffacf5bc7940 x28: dfffffd000000000
> > > [   93.758448] x27: ffffffacdb11a800 x26: dfffffd000000000
> > > [   93.763916] x25: ffffffd0734f856c x24: dfffffd000000000
> > > [   93.769389] x23: 0000000000000000 x22: ffffffd0733c35b0
> > > [   93.774860] x21: ffffffd0751994a0 x20: ffffffd075ec27c0
> > > [   93.780338] x19: ffffffd075199100 x18: 00000000000276e0
> > > [   93.785814] x17: 0000000000000000 x16: dfffffd000000000
> > > [   93.791291] x15: ffffffffffffffff x14: 6e6968207473696c
> > > [   93.796768] x13: 0000000000000000 x12: ffffffd075e2b000
> > > [   93.802244] x11: 0000000000000001 x10: 0000000000000000
> > > [   93.807723] x9 : d13400dff1921900 x8 : d13400dff1921900
> > > [   93.813200] x7 : 0000000000000000 x6 : 0000000000000000
> > > [   93.818676] x5 : 0000000000000080 x4 : 0000000000000000
> > > [   93.824152] x3 : ffffffd0732a0fa4 x2 : 0000000000000001
> > > [   93.829628] x1 : ffffffacf5bc7580 x0 : 0000000000000061
> > > [   93.835104] Call trace:
> > > [   93.837644]  debug_print_object+0x13c/0x1b0
> > > [   93.841963]  __debug_check_no_obj_freed+0x25c/0x3c0
> > > [   93.846987]  debug_check_no_obj_freed+0x18/0x20
> > > [   93.851669]  slab_free_freelist_hook+0xbc/0x1e4
> > > [   93.856346]  kfree+0xfc/0x2f4
> > > [   93.859416]  rpmsg_ctrldev_release_device+0x78/0xb8
> > > [   93.864445]  device_release+0x84/0x168
> > > [   93.868310]  kobject_cleanup+0x12c/0x298
> > > [   93.872356]  kobject_delayed_cleanup+0x10/0x18
> > > [   93.876948]  process_one_work+0x578/0x92c
> > > [   93.881086]  worker_thread+0x804/0xcf8
> > > [   93.884963]  kthread+0x2a8/0x314
> > > [   93.888303]  ret_from_fork+0x10/0x18
> > > 
> > > The cdev_device_add/del() API was created to address this issue
> > > (see commit 233ed09d7fda), use it instead of cdev add/del().
> > > 
> > > Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > 
> > > Changes in v4:
> > > - call cdev_device_del() from rpmsg_chrdev_remove() instead of
> > >   rpmsg_ctrldev_release_device()
> > > - updated subject (was: "rpmsg: glink: Update cdev add/del API in
> > >   rpmsg_ctrldev_release_device()")
> > > - updated commit message
> > > - replaced backtrace in commit message with one that doesn't have
> > >   a dump_backtrace() call
> > > 
> > > Changes in v3:
> > > - Remove unecessary error check as per Matthias's comment
> > > 
> > > Changes in v2:
> > > - Fix typo in commit message
> > > 
> > >  drivers/rpmsg/rpmsg_char.c | 11 ++---------
> > >  1 file changed, 2 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > > index b5907b80727c..b1b75ef04560 100644
> > > --- a/drivers/rpmsg/rpmsg_char.c
> > > +++ b/drivers/rpmsg/rpmsg_char.c
> > > @@ -459,7 +459,6 @@ static void rpmsg_ctrldev_release_device(struct device *dev)
> > >  
> > >  	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> > >  	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> > > -	cdev_del(&ctrldev->cdev);
> > >  	kfree(ctrldev);
> > >  }
> > >  
> > > @@ -494,19 +493,13 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
> > >  	dev->id = ret;
> > >  	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
> > >  
> > > -	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
> > > +	ret = cdev_device_add(&ctrldev->cdev, &ctrldev->dev);
> > >  	if (ret)
> > >  		goto free_ctrl_ida;
> > >  
> > >  	/* We can now rely on the release function for cleanup */
> > >  	dev->release = rpmsg_ctrldev_release_device;
> > >  
> > > -	ret = device_add(dev);
> > > -	if (ret) {
> > > -		dev_err(&rpdev->dev, "device_add failed: %d\n", ret);
> > > -		put_device(dev);
> > > -	}
> > > -
> > >  	dev_set_drvdata(&rpdev->dev, ctrldev);
> > >  
> > >  	return ret;
> > > @@ -532,7 +525,7 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
> > >  	if (ret)
> > >  		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
> > >  
> > > -	device_del(&ctrldev->dev);
> > > +	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
> > >  	put_device(&ctrldev->dev);
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > I'll let Bjorn pick this one to make sure it doesn't break anything for current
> > users of the driver.
> 
> Bjorn: can this land or is there any action pending on my side?

Thanks for the ping Mathieu, this looks good to me, so:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

But it should come with:

Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")

But afaict we have the exact same problem in rpmsg_eptdev_create(), is
there a reason why this isn't updated as well?

Regards,
Bjorn
