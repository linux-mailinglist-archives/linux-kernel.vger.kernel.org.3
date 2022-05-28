Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD6536DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiE1RhO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 28 May 2022 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiE1RhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 13:37:11 -0400
Received: from relay5.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA39E93;
        Sat, 28 May 2022 10:37:10 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 15D0160F8D;
        Sat, 28 May 2022 17:37:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id F17FB2002B;
        Sat, 28 May 2022 17:36:58 +0000 (UTC)
Message-ID: <083c936b74c2a2aef678e7b89be22e00c596144f.camel@perches.com>
Subject: Re: [PATCH 1/1] iio: Prefer octal over symbolic permissions.
From:   Joe Perches <joe@perches.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 28 May 2022 10:36:57 -0700
In-Reply-To: <20220528183405.22b55033@jic23-huawei>
References: <20220527185651.465204-1-joetalbott@gmail.com>
         <20220528183405.22b55033@jic23-huawei>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: F17FB2002B
X-Stat-Signature: efa8a1fko9joascwid7grn1mu5qj3w7e
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/npUr6jS/AkRCw99c0tVLfC7u6v3NQBKs=
X-HE-Tag: 1653759418-698807
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-28 at 18:34 +0100, Jonathan Cameron wrote:
> On Fri, 27 May 2022 14:56:52 -0400
> Joe Simmons-Talbott <joetalbott@gmail.com> wrote:
> > As reported by checkpatch.pl use ocatl permissions rather than symbolic
> > permissions.
[]
> Why the resend?  Given change of description, I'm guessing this is v2
> because of feedback on a similar patch elsewhere. If so, please
> put the version number in the patch log and provide a changelog
> below the ---
> 
> Hmm. I guess I don't really mind cleaning this up though it is
> some churn in core code which is usually something we try to avoid
> for fairly trivial style reasons.
> 
> One request inline (though I suspect it applies in several places,
> I just haven't checked ;)
[]
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
[]
> > @@ -1391,17 +1391,17 @@ static ssize_t direction_show(struct device *dev,
> >  	}
> >  }
> >  
> > -static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> > +static DEVICE_ATTR(length, 0644, iio_buffer_read_length,
> >  		   iio_buffer_write_length);
> >  static struct device_attribute dev_attr_length_ro = __ATTR(length,
> > -	S_IRUGO, iio_buffer_read_length, NULL);
> > -static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR,
> > +	0444, iio_buffer_read_length, NULL);
> > +static DEVICE_ATTR(enable, 0644,
> >  		   iio_buffer_show_enable, iio_buffer_store_enable);
> > -static DEVICE_ATTR(watermark, S_IRUGO | S_IWUSR,
> > +static DEVICE_ATTR(watermark, 0644,
> >  		   iio_buffer_show_watermark, iio_buffer_store_watermark);
> >  static struct device_attribute dev_attr_watermark_ro = __ATTR(watermark,
> > -	S_IRUGO, iio_buffer_show_watermark, NULL);
> > -static DEVICE_ATTR(data_available, S_IRUGO,
> > +	0444, iio_buffer_show_watermark, NULL);
> > +static DEVICE_ATTR(data_available, 0444,
> >  		iio_dma_show_data_available, NULL);
> 
> a side effect of this change a slight shortening of how long the above
> two lines will be if combined into one.  It's now sub 80 chars
> I think, so please make them a single line.  Also check for similar
> cases elsewhere.

another possibility it to rename the function to <var>_show and change

	static DEVICE_ATTR(foo, 0444, <var>, NULL)
to
	static DEVICE_ATTR_RO(<var>)

and also use

DEVICE_ATTR_RW

with appropriate function renaming where feasible.
