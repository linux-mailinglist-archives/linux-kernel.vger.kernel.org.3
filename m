Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCE4AE7C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbiBIDNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbiBIDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:12:51 -0500
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3305DC061355
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:12:48 -0800 (PST)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 900DA120CE6;
        Wed,  9 Feb 2022 03:12:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id CB22120026;
        Wed,  9 Feb 2022 03:12:44 +0000 (UTC)
Message-ID: <f4b63b5a4177e38dd80f102f87bbec3ea77d9fe8.camel@perches.com>
Subject: Re: [PATCH] scsi: csiostor: replace snprintf with sysfs_emit
From:   Joe Perches <joe@perches.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        davidcomponentone@gmail.com, jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, bvanassche@acm.org,
        yang.guang5@zte.com.cn, jiapeng.chong@linux.alibaba.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Date:   Tue, 08 Feb 2022 19:12:43 -0800
In-Reply-To: <148a5448-71f1-4f39-834b-eb9283de0bfb@opensource.wdc.com>
References: <d711ec5a5f416204079155666d2de49d43070897.1644287527.git.yang.guang5@zte.com.cn>
         <148a5448-71f1-4f39-834b-eb9283de0bfb@opensource.wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8gchddikwsrfirqmowadkhtbrfngo7uf
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: CB22120026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18+kwIE1/o3TfCnWkTjoHV4vtyCYF4Lx6w=
X-HE-Tag: 1644376364-883225
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-09 at 11:36 +0900, Damien Le Moal wrote:
> On 2/9/22 09:40, davidcomponentone@gmail.com wrote:
> > From: Yang Guang <yang.guang5@zte.com.cn>
> > 
> > coccinelle report:
> > ./drivers/scsi/csiostor/csio_scsi.c:1433:8-16:
> > WARNING: use scnprintf or sprintf
> > ./drivers/scsi/csiostor/csio_scsi.c:1369:9-17:
> > WARNING: use scnprintf or sprintf
> > ./drivers/scsi/csiostor/csio_scsi.c:1479:8-16:
> > WARNING: use scnprintf or sprintf
> > 
> > Use sysfs_emit instead of scnprintf or sprintf makes more sense.
[]
> > diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
[]
> > @@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
> >  	struct csio_hw *hw = csio_lnode_to_hw(ln);
> >  
> >  	if (csio_is_hw_ready(hw))
> > -		return snprintf(buf, PAGE_SIZE, "ready\n");
> > +		return sysfs_emit(buf, "ready\n");
> >  	else
> > -		return snprintf(buf, PAGE_SIZE, "not ready\n");
> > +		return sysfs_emit(buf, "not ready\n");
> 
> While at it, you could remove the useless "else" above.

Or not.  It's fine as is.  It's just a style preference.

Another style option would be to use a ?: like any of

	return sysfs_emit(buf, "%sready\n", csio_is_hw_ready(hw) ? "" : "not ");
or
	return sysfs_emit(buf, "%s\n", csio_is_hw_ready(hw) ? "ready" : "not ready");
or
	return sysfs_emit(buf, csio_is_hw_ready(hw) ? "ready\n" : "not ready\n");


