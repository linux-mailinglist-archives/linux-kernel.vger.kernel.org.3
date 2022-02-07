Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D634AC7DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345718AbiBGRqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383570AbiBGRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:35:09 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EFBC0401E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:35:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i17so14156201pfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+F8Z93ydaAZwGiy3/15vH3eFEMPs2AfvJMctmWhsG70=;
        b=TjzITW+3Z0nAL0osm0ypAygxlkHOt0JRm2p0UnMGlkOfPRS/Q4pyFimH413PWRFwcD
         6VT8tpGXL+a/3TITw/4dU4HGCjpwJlOubIMRf/hNzS+IkbhiSgV2NS53E8UmaIoNIo7H
         lHu0kFMC4nJA7FCVtlrenQD1cdvOHwI0dHxKmRzxJG/v3dWaWYmjApzQfR4MnHn6Nj7B
         8q47yl06Q0g/88BvblgYmcrAWe/7uk+/Wym+UMKOE8qrvg9oCp003WbD9HDXGdn6U3q+
         s3kakdwh3iKLtOfL8QVuXddsXT8VKlo+dPRXP2I83ymJhQ/D79gAkITZWoUFhhkDKjzC
         B+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+F8Z93ydaAZwGiy3/15vH3eFEMPs2AfvJMctmWhsG70=;
        b=RZ0svQIYqicr/xrm7llcyC20dXv9FwBp0ZjKPI/GIsiov8/j1/E3/zalQsnLjNhWq0
         A0hN8etMqZT+4PPF7gW3StZl3slcyyuQKCwaEzrMOe+SQId+4VcXD2FpBg32rH9KzBO8
         b9XvoAtqrE6xrcF1HjHVeQTr8zthEYq95Q+qrFhaL/vMwLHus7qPiq5mBYKrRF3hiBWX
         zWuPI+ogCO4IB34619BJPugVrfTE2Q6KqpGY8pyiPEfKautHAkNfYLSuRDDozagMWxRO
         ENUN9W+YQd6FYjDUqCyTG92dKlz6Qs3O9tH1fao7cI6K5vDhtpBTk59r9yEmg4T9i1E/
         y4Ow==
X-Gm-Message-State: AOAM533+9zPg3JGDZFfgtMhvjR/OrQd9iN39R0HcGT05j2nXY4ymHczK
        OTGVlu9D9vlqz3JeFPoM4CgbDQ==
X-Google-Smtp-Source: ABdhPJxB+G3fd5zZI61qSXLsymCHjEJIsm+xb88Amu75Oq49JeaJN63RBJgI/Xa7ueVXFlieDoMg3A==
X-Received: by 2002:a65:4286:: with SMTP id j6mr348633pgp.619.1644255299825;
        Mon, 07 Feb 2022 09:34:59 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e20sm12236492pfn.4.2022.02.07.09.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:34:58 -0800 (PST)
Date:   Mon, 7 Feb 2022 10:34:56 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>, arnaud.pouliquen@foss.st.com,
        hnagalla@ti.com
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] remoteproc: support self recovery after rproc crash
Message-ID: <20220207173456.GA3355405@p14s>
References: <20220126085120.3397450-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94176981E1D8F54557317513882C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94176981E1D8F54557317513882C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 01:31:07AM +0000, Peng Fan wrote:
> > Subject: [PATCH V2] remoteproc: support self recovery after rproc crash
> 
> Any comments?

Well... At this time there is two patchsets on the mailing list that are
introducing serious changes to the subsystem - yours and Arnaud's virtio
refactoring work:

. [PATCH V2] remoteproc: support self recovery after rproc crash
. [RFC PATCH v3 0/4] remoteproc: restructure the remoteproc VirtIO device

Both patchsets have ramifications for NXP, ST and TI.  As such I am expecting
you, Arnaud and Hari to review those before I start looking at them.

> 
> Thanks,
> Peng.
> 
> > 
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Current logic only support main processor to stop/start the remote processor
> > after rproc crash. However to SoC, such as i.MX8QM/QXP, the remote
> > processor could do self recovery after crash and trigger watchdog reboot. It
> > does not need main processor to load image, stop/start M4 core.
> > 
> > This patch add a new flag to indicate whether the SoC has self recovery
> > capability. And introduce two functions: rproc_self_recovery,
> > rproc_assisted_recovery for the two cases. Assisted recovery is as before, let
> > main processor to help recovery, while self recovery is recover itself withou
> > help. To self recovery, we only do detach and attach.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > 
> > V2:
> >  Nothing change in V2.
> >  Only move this patch out from
> >  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364
> > 
> >  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++++++--------
> >  include/linux/remoteproc.h           |  2 +
> >  2 files changed, 49 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > index 69f51acf235e..4bd5544dab8f 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1887,6 +1887,49 @@ static int __rproc_detach(struct rproc *rproc)
> >  	return 0;
> >  }
> > 
> > +static int rproc_self_recovery(struct rproc *rproc) {
> > +	int ret;
> > +
> > +	mutex_unlock(&rproc->lock);
> > +	ret = rproc_detach(rproc);
> > +	mutex_lock(&rproc->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (atomic_inc_return(&rproc->power) > 1)
> > +		return 0;
> > +	return rproc_attach(rproc);
> > +}
> > +
> > +static int rproc_assisted_recovery(struct rproc *rproc) {
> > +	const struct firmware *firmware_p;
> > +	struct device *dev = &rproc->dev;
> > +	int ret;
> > +
> > +	ret = rproc_stop(rproc, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* generate coredump */
> > +	rproc->ops->coredump(rproc);
> > +
> > +	/* load firmware */
> > +	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "request_firmware failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* boot the remote processor up again */
> > +	ret = rproc_start(rproc, firmware_p);
> > +
> > +	release_firmware(firmware_p);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * rproc_trigger_recovery() - recover a remoteproc
> >   * @rproc: the remote processor
> > @@ -1901,7 +1944,6 @@ static int __rproc_detach(struct rproc *rproc)
> >   */
> >  int rproc_trigger_recovery(struct rproc *rproc)  {
> > -	const struct firmware *firmware_p;
> >  	struct device *dev = &rproc->dev;
> >  	int ret;
> > 
> > @@ -1915,24 +1957,10 @@ int rproc_trigger_recovery(struct rproc *rproc)
> > 
> >  	dev_err(dev, "recovering %s\n", rproc->name);
> > 
> > -	ret = rproc_stop(rproc, true);
> > -	if (ret)
> > -		goto unlock_mutex;
> > -
> > -	/* generate coredump */
> > -	rproc->ops->coredump(rproc);
> > -
> > -	/* load firmware */
> > -	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> > -	if (ret < 0) {
> > -		dev_err(dev, "request_firmware failed: %d\n", ret);
> > -		goto unlock_mutex;
> > -	}
> > -
> > -	/* boot the remote processor up again */
> > -	ret = rproc_start(rproc, firmware_p);
> > -
> > -	release_firmware(firmware_p);
> > +	if (rproc->self_recovery)
> > +		ret = rproc_self_recovery(rproc);
> > +	else
> > +		ret = rproc_assisted_recovery(rproc);
> > 
> >  unlock_mutex:
> >  	mutex_unlock(&rproc->lock);
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h index
> > e0600e1e5c17..b32ef46f8aa4 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -529,6 +529,7 @@ struct rproc_dump_segment {
> >   * @elf_machine: firmware ELF machine
> >   * @cdev: character device of the rproc
> >   * @cdev_put_on_release: flag to indicate if remoteproc should be
> > shutdown on @char_dev release
> > + * @self_recovery: flag to indicate if remoteproc support self recovery
> >   */
> >  struct rproc {
> >  	struct list_head node;
> > @@ -568,6 +569,7 @@ struct rproc {
> >  	u16 elf_machine;
> >  	struct cdev cdev;
> >  	bool cdev_put_on_release;
> > +	bool self_recovery;
> >  };
> > 
> >  /**
> > --
> > 2.25.1
> 
