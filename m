Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0EB55A943
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiFYLHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 07:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiFYLHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:07:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDFA344C4;
        Sat, 25 Jun 2022 04:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15BEACE0B02;
        Sat, 25 Jun 2022 11:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DD1C341C7;
        Sat, 25 Jun 2022 11:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656155256;
        bh=rr4kKRfEEwrsfzQYp1zAY1a97o4UrXD52+rh79sxy/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGXAky8ojeOmMZQ/stXpW4Xg6oYsma4FrVAqJMojT6PjSTyL3LkVw86MqnCJ1qvqj
         qdsqKllbwFP7UsciSXp0f8jtdlmnnIdbcUt1xKtZldlsO42ePQuzM+PCHiG11mV3Vy
         A4QfwySQoa46pQtxtiQXSIdni+hwbgeHUkBYoKhRvOn5Gw3FqfIQ56IWHVQoB6xFcQ
         Hs9Bzaj9V3JM7tlAesUvInXkIkXjvt34CPhbpuxrs/k88VmT/4kKIVl483HRaMl5Q/
         c+hJRPg7NzPm0uhfkBHnndQJvfOCkBcn6eBGPyA1LBbpKqDI5ET05IMY1kTEc1g84Q
         eJc1cfbQuOTew==
Date:   Sat, 25 Jun 2022 12:17:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Don't use bare "unsigned"
Message-ID: <20220625121705.42063d6a@jic23-huawei>
In-Reply-To: <20220624021806.1010962-1-joetalbott@gmail.com>
References: <20220624021806.1010962-1-joetalbott@gmail.com>
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

On Thu, 23 Jun 2022 22:18:06 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> Use "unsigned int" rather than bare "unsigned". Reported by checkpatch.pl.
> 
> Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>

I've always wondered when someone would get around to tidying this up.
Never seemed worth the effort to do it myself :)

Anyhow, thanks.  Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c     | 10 +++++-----
>  drivers/iio/industrialio-core.c       |  4 ++--
>  drivers/iio/industrialio-sw-device.c  |  2 +-
>  drivers/iio/industrialio-sw-trigger.c |  2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b078eb2f3c9d..513a34a0b593 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -705,7 +705,7 @@ static unsigned int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
>  static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>  				const unsigned long *mask, bool timestamp)
>  {
> -	unsigned bytes = 0;
> +	unsigned int bytes = 0;
>  	int length, i, largest = 0;
>  
>  	/* How much space will the demuxed element take? */
> @@ -934,9 +934,9 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>   * @l:		list head used for management
>   */
>  struct iio_demux_table {
> -	unsigned from;
> -	unsigned to;
> -	unsigned length;
> +	unsigned int from;
> +	unsigned int to;
> +	unsigned int length;
>  	struct list_head l;
>  };
>  
> @@ -974,7 +974,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>  				   struct iio_buffer *buffer)
>  {
>  	int ret, in_ind = -1, out_ind, length;
> -	unsigned in_loc = 0, out_loc = 0;
> +	unsigned int in_loc = 0, out_loc = 0;
>  	struct iio_demux_table *p = NULL;
>  
>  	/* Clear out any old demux */
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e1ed44dec2ab..ca28f76b8f40 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -384,7 +384,7 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
>  {
>  	struct iio_dev *indio_dev = file->private_data;
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	unsigned val = 0;
> +	unsigned int val = 0;
>  	int ret;
>  
>  	if (*ppos > 0)
> @@ -414,7 +414,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
>  {
>  	struct iio_dev *indio_dev = file->private_data;
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	unsigned reg, val;
> +	unsigned int reg, val;
>  	char buf[80];
>  	int ret;
>  
> diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
> index 49f775f16ad5..cdaf30a3f233 100644
> --- a/drivers/iio/industrialio-sw-device.c
> +++ b/drivers/iio/industrialio-sw-device.c
> @@ -27,7 +27,7 @@ static DEFINE_MUTEX(iio_device_types_lock);
>  
>  static
>  struct iio_sw_device_type *__iio_find_sw_device_type(const char *name,
> -						     unsigned len)
> +						     unsigned int len)
>  {
>  	struct iio_sw_device_type *d = NULL, *iter;
>  
> diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
> index 9ae793a70b8b..994f03a71520 100644
> --- a/drivers/iio/industrialio-sw-trigger.c
> +++ b/drivers/iio/industrialio-sw-trigger.c
> @@ -27,7 +27,7 @@ static DEFINE_MUTEX(iio_trigger_types_lock);
>  
>  static
>  struct iio_sw_trigger_type *__iio_find_sw_trigger_type(const char *name,
> -						       unsigned len)
> +						       unsigned int len)
>  {
>  	struct iio_sw_trigger_type *t = NULL, *iter;
>  

