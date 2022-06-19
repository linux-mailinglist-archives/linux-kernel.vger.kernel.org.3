Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA603550AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiFSMfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFSMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:35:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44D62DF;
        Sun, 19 Jun 2022 05:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B175B80CAA;
        Sun, 19 Jun 2022 12:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437C1C341D1;
        Sun, 19 Jun 2022 12:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655642128;
        bh=q6lkeo/SrEPWQ+2brReD5ukp5cS1BU9o1wOUu1pRlN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ub9RWeLV6l+SAYChJ8kHMkq9JWcH1okn3+XjllXUvnylITVeaEUpE8zWiOzwCP0/K
         4eUHLrfxcYEAbhSo7oA6aKL2BfWtfSzSJrJQ0JlYVd8yT+Eltlwh5SV9uJUJiMzeHz
         kE+diiOmDVNTHQhgdMnrTF+yxhvEJZ+HWRP5tRwDk5BaWSXmmvBFHpFaALJ/H2uT1h
         tZcWrXHrNiY+1+0axtDYoZ130v1TwoKYroJHqeBWnC+3RTg7ju1gfxzNsZuL+WiIgj
         SxBAxIW302hGzNkUadrjewhT//N1xTu3JQxAfldic3g7M/+L1vyCZehIZ01ZllMaf9
         /es6eeG9kShcA==
Date:   Sun, 19 Jun 2022 13:44:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com, Dmitry Osipenko <digetx@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] iio: light: Add support for ltrf216a sensor
Message-ID: <20220619134443.23874255@jic23-huawei>
In-Reply-To: <CAHp75VeU9oSJmMdyT_0BZDuG5WMiuJiCPv5So4DWG05EEDKrhw@mail.gmail.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
        <20220615135130.227236-3-shreeya.patel@collabora.com>
        <CAHp75VeU9oSJmMdyT_0BZDuG5WMiuJiCPv5So4DWG05EEDKrhw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> > +       /* reset sensor, chip fails to respond to this, so ignore any errors */
> > +       ltrf216a_reset(indio_dev);
> > +
> > +       ret = pm_runtime_set_active(&client->dev);
> > +       if (ret)
> > +               goto error_power_down;  
> 
> Why do you need to power down here?
> 
> > +       pm_runtime_enable(&client->dev);

We now have devm_pm_runtime_enable() which will also deal
with disabling use_autosuspend for you and should help you
sort out some of the ordering.


> > +       pm_runtime_set_autosuspend_delay(&client->dev, 5000);
> > +       pm_runtime_use_autosuspend(&client->dev);
> > +
> > +       ltrf216a_set_power_state(data, true);  
> 
> The below code suggests that you are mixing badly devm_ with non-devm_
> APIs, don't do this. You have to group devm_ first followed by
> non-devm_ calls.
> 
> ...
> 
> > +static int ltrf216a_remove(struct i2c_client *client)
> > +{
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +
> > +       iio_device_unregister(indio_dev);
> > +       pm_runtime_disable(&client->dev);
> > +       pm_runtime_set_suspended(&client->dev);
> > +       ltrf216a_disable(indio_dev);
> > +
> > +       return 0;  
> 
> I believe the ordering of freeing resources and reverting state is not
> in reverse. See above why.

In particular you are calling disable there which is already handled
by devm_ unwinding.
> 
> > +}  
> 


