Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9050E540
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbiDYQOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbiDYQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:13:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B68457B3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:10:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id bo5so15229187pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NzLTDT2IhgocKZKLBPfCzs7lhR1yZQjCwOZbx7KRLTg=;
        b=oI8XT1uHa4eoJ1UFRSstq3A4sup6lW+z5ny8eV5YuU9ddf5Hn5HusrrlWreu+EajyX
         jI54mZlCCYN/dGsY5Dtup97rdwNTxl3ccUwvJyc9nI5t7RC54BhQwx7UELHN8Dy/INos
         nO2+4sygc8nbZEGl32gGnfCj0tdfej/fR4gDzlZTwJtp8/wdIxgIHP4Dnq0ubjqSp8vP
         IiYmnKcoRsjpMr+1PDGTYU9066cv99ZvsLkLRiafv8K+gQ/U90isYTQyDyfOWwr1fN/q
         AyNGq/6NKaM0W0zoO57gugdG6TNZveaJ+06AIzpeie3fFOMDNBpvUKiGs8/OzMPdK9aO
         YtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NzLTDT2IhgocKZKLBPfCzs7lhR1yZQjCwOZbx7KRLTg=;
        b=yu+FJNoySWZlJxmVGFtvwQ7bRqguSt6tvl7KFYBU2mhNy6+VG67eYKi/FkHI/lpPgS
         4Np2CMVWXpH2uOifJmzSrQKIgxo6AQa9bAd65bfdYJo9Yc4rixddFvUQ6VmieOnPDH8/
         j6thSpX+aMh6uWRBctgYO+Dv1I6UU7KqnuFHKc9DH/QYCWFENWZIswXaK65wUHzQVnLW
         VK0J+aXkL7jHcWYoltaeVsLfdsgHilEcs+d3Frh3VN7rAr05PjuSLUHLr0ZuLH9z5XYn
         3DNcM1x0dCRRTJMtjrmCoMYiYvplFrXHNBxHJtPqba4t+1D0BIRzzWGZhygDAAH0q+Z8
         DBaA==
X-Gm-Message-State: AOAM530zQh8Tk1c/W4gCnJNLtvGn8JPPZOY8FV9bcL+9HGsYywGxWpX3
        u2Dyh5OtiZB/c8nEknmMLhvNxQ==
X-Google-Smtp-Source: ABdhPJwd9GSMxJuQqx1QMLV21SmOrSHoXMBOl8ZXkog4xj/xIGIdt8EUgtEry3elVyU4mFmyODRv4A==
X-Received: by 2002:a05:6a00:b4d:b0:509:1ed1:570e with SMTP id p13-20020a056a000b4d00b005091ed1570emr19518664pfo.19.1650903054831;
        Mon, 25 Apr 2022 09:10:54 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id bv1-20020a17090af18100b001d8ace370cbsm10826119pjb.54.2022.04.25.09.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:10:53 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:10:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coresight: etm4x: return 0 instead of using local ret
 variable
Message-ID: <20220425161051.GA1917807@p14s>
References: <20220422020239.37186-1-shile.zhang@linux.alibaba.com>
 <20220422154558.GA1713394@p14s>
 <b1654ab7-b783-ac59-ee94-13527135f406@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1654ab7-b783-ac59-ee94-13527135f406@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 02:57:24PM +0800, Shile Zhang wrote:
> 
> 
> On 2022/4/22 23:45, Mathieu Poirier wrote:
> > On Fri, Apr 22, 2022 at 10:02:39AM +0800, Shile Zhang wrote:
> > > The function etm4_remove_dev() always return 0, and the former function
> > > etm4_remove has been changed to void in commit 3fd269e74f2fe ("amba: Make
> > > the remove callback return void"). But now its changed back to int type
> > > for some reason, which is different to the stable branch linux-5.10.y.
> > 
> > Please spend time understanding why function etm4_remove_dev()'s return value
> > has been changed back to an "int".  From there you will likely come to the
> > conclusion that adding the above to the changelog doesn't make sense.
> 
> Sorry, I means "some reason" here actually I cannot find out why.
> 
> 1. From the git log of the file
> `drivers/hwtracing/coresight/coresight-etm4x-core.c', only log of
> etm4_remove changes to void in commit 3fd269e74f2fe. no any log record when
> it change back to int.
> 2. from the commit 'git log --pretty="%h %ci %cn %s"
> drivers/hwtracing/coresight/coresight-etm4x-core.c'
> ...
> b8336ad947e19 2021-02-04 17:00:32 +0100 Greg Kroah-Hartman coresight: etm4x:
> add AMBA id for Cortex-A55 and Cortex-A75
> 3fd269e74f2fe 2021-02-02 14:25:50 +0100 Uwe Kleine-König amba: Make the
> remove callback return void
> ...
> 
> The commit 'b8336ad947e19' does not change the etm4_remove:
> https://github.com/torvalds/linux/commit/b8336ad947e1913b9bb5cdf4f54b687654160d42
> 
> But the different between the commit 'b8336ad947e19' and '3fd269e74f2fe'
> contains the changes of etm4_remove back to int, as following:
> ---
> ...
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 82787cba537d3..8c4b0c46c8f32 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1680,7 +1680,7 @@ static void clear_etmdrvdata(void *info)
>         etmdrvdata[cpu] = NULL;
>  }
> 
> -static void etm4_remove(struct amba_device *adev)
> +static int etm4_remove(struct amba_device *adev)
>  {
>         struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> 
> @@ -1703,6 +1703,8 @@ static void etm4_remove(struct amba_device *adev)
>         cpus_read_unlock();
> 
>         coresight_unregister(drvdata->csdev);
> +
> +       return 0;
>  }
> 
>  static const struct amba_id etm4_ids[] = {
> @@ -1711,6 +1713,8 @@ static const struct amba_id etm4_ids[] = {
>         CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
>         CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
>         CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> +       CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
> +       CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
>         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
>         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
>         CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
> ...
> ---
> 
> I really don't know how to check which commit change it back.
> Could you please help to give me some guidance?

Have a look at "git blame" - it is really useful to know what commit introduced a
change.  In this case, and using coresight next (c86dd9869128), the command
would be:

$ git blame -L 2059,2059 drivers/hwtracing/coresight/coresight-etm4x-core.c

That will tell you how function etm4_remove_dev() got to return an 'int' again.  

But this is really about understanding the current code rather than trying to
understand the history of it.  With commit 3fd269e74f2fe, Uwe was making amba
remove callback functions return a 'void'.  And this is what we see here[1] in
v5.10.112.  Note that etm4_remove() is the callback to the amba driver.

In the mainline code, the amba callback function is now etm4_remove_amba() and
still returns a 'void'.  Function etm4_remove() is now etm4_remove_dev() and is
called by both etm4_remove_amba() and etm4_remove_platform_dev(), to avoid code
duplication.

The conclusion is that because etm4_remove_dev() no longer interfaces with the
amba subsystem, its return value can be 'int'.  But in this case the return
value is not used and as such can be changed to a 'void', regardless of commit
3fd269e74f2fe. 

Mathieu

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/hwtracing/coresight/coresight-etm4x-core.c?h=v5.10.112#n1585

> 
> Thanks!
> 
> 
> > 
> > > 
> > > Just let it return void and return 0 directly in it's caller function
> > > etm4_remove_platform_dev.
> > 
> > The only rational for this patch is that etm4_remove_dev() always returns '0'.
> > And even if it was to return anything else, the return value it not checked.
> > And even if the return value was checked, there is nothing to do about an error
> > condition since the driver is being removed.
> > 
> > > 
> > > Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> > > ---
> > > v2: re-work the commit log from Mathieu's suggestion.
> > > v1: https://lore.kernel.org/linux-arm-kernel/20220421164217.GB1596562@p14s/T/
> > > ---
> > >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 +++++------
> > >   1 file changed, 5 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > index 7f416a12000eb..141f8209a152a 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > @@ -2104,7 +2104,7 @@ static void clear_etmdrvdata(void *info)
> > >   	etmdrvdata[cpu] = NULL;
> > >   }
> > > -static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
> > > +static void __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
> > >   {
> > >   	etm_perf_symlink(drvdata->csdev, false);
> > >   	/*
> > > @@ -2125,8 +2125,6 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
> > >   	cscfg_unregister_csdev(drvdata->csdev);
> > >   	coresight_unregister(drvdata->csdev);
> > > -
> > > -	return 0;
> > >   }
> > >   static void __exit etm4_remove_amba(struct amba_device *adev)
> > > @@ -2139,13 +2137,14 @@ static void __exit etm4_remove_amba(struct amba_device *adev)
> > >   static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
> > >   {
> > > -	int ret = 0;
> > >   	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> > >   	if (drvdata)
> > > -		ret = etm4_remove_dev(drvdata);
> > > +		etm4_remove_dev(drvdata);
> > > +
> > >   	pm_runtime_disable(&pdev->dev);
> > > -	return ret;
> > > +
> > > +	return 0;
> > >   }
> > >   static const struct amba_id etm4_ids[] = {
> > > -- 
> > > 2.33.0.rc2
> > > 
