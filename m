Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B624F5A8A06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiIAAv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiIAAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:51:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF917D87E6;
        Wed, 31 Aug 2022 17:51:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p185so16027379pfb.13;
        Wed, 31 Aug 2022 17:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=L02Sp50hPwKNmfsR7li6CwKxaHvMpyrjFzMp+2/RDYc=;
        b=YifSQirQGhLAjW66wrrOh4zVneYTdfs1QnXaG48PYfcduXj4zsFO077Z/ZDE0cDM2q
         YfbcDVb5XJAp2l/Qxug9wF150vOWJvZaJCT5P0SpLPkPASaOxxr4Nnu3vg76nIW/xEEV
         BtGeqxUQEtVJ7mA/0ddwxHYmjKGboY7hpx2TCvgmvc5no+ksC2UFDwshDIkpyJiNKHr5
         tXxWsq76ISWPQj+WmuWNb6V7NH+wB7MjLL2Gss/cR8g06jWvQ8FR+W3B9ME5rT7/cqbK
         hYq+sef+l77lOoYSQlkyyymIEsXKN6q8U7k5gWcDbz8tlb6WoXNIK3Az5ujmv1bOmlZB
         VAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=L02Sp50hPwKNmfsR7li6CwKxaHvMpyrjFzMp+2/RDYc=;
        b=ZnsTq/ZkhxCHlUkYkXoCNxlyw4QxuQU97V7+89mFsYrLId4fX3xPRHXDvHHx/NfKNS
         /603BUBC54j4reATSEu3RVPg2xGURSAnOQ073Bu7QHf9yZ0i8YZgKbbiJcxIi8u6JZJh
         P3VmHVH29DToT9JFJwRq5bSL/JED4UZZNaABz4smsb9Sa/3GumvlAhBEeuRWl7+X287+
         5sgPf1fHpMbgn69cZePU45lUkA5KLvUazcRA/kHSbjdh96aC+mPrXzTJg//E/RQgIrQl
         U/VE+FVl0iFwIWAoWw6opjBt75/S1NgXray6d5ZOTzfpbDC50V7+gpzYAF8FE2t+5irk
         osBw==
X-Gm-Message-State: ACgBeo3/cggA4b1KCsNUAQCt5hF0sn6PxtqqtBPOKxH5p37l4OAjm5NT
        zpSmSCtwND0q9JYB1zfK8mo=
X-Google-Smtp-Source: AA6agR6gpVpjALUClbmTEgMzN+B80iOVObZm2fd2eiysi4JbneIjQ7VClEXw/bKexeeYHktLEdRIIw==
X-Received: by 2002:a63:d1f:0:b0:422:7774:1969 with SMTP id c31-20020a630d1f000000b0042277741969mr23785234pgl.88.1661993481278;
        Wed, 31 Aug 2022 17:51:21 -0700 (PDT)
Received: from carlis-virtual-machine ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id d81-20020a621d54000000b0052ac12e7596sm11771524pfd.114.2022.08.31.17.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:51:20 -0700 (PDT)
Date:   Thu, 1 Sep 2022 08:51:14 +0800
From:   <zhangxuezhi3@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        johannes.thumshirn@wdc.com, himanshu.madhani@oracle.com,
        zhangxuezhi1@coolpad.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: convert sysfs snprintf to sysfs_emit
Message-ID: <20220901085114.4a6a5a99@carlis-virtual-machine>
In-Reply-To: <b2a4ba8c-c67b-3041-9b81-783611de0763@opensource.wdc.com>
References: <20220831141046.406837-1-zhangxuezhi3@gmail.com>
        <b2a4ba8c-c67b-3041-9b81-783611de0763@opensource.wdc.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 09:23:58 +0900
Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:

> On 8/31/22 23:10, Xuezhi Zhang wrote:
> > From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> > 
> > Fix up all sysfs show entries to use sysfs_emit
> > 
> > Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> > ---
> >  drivers/scsi/csiostor/csio_scsi.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/scsi/csiostor/csio_scsi.c
> > b/drivers/scsi/csiostor/csio_scsi.c index
> > 9aafe0002ab1..39e8c3c26a19 100644 ---
> > a/drivers/scsi/csiostor/csio_scsi.c +++
> > b/drivers/scsi/csiostor/csio_scsi.c @@ -1366,9 +1366,9 @@
> > csio_show_hw_state(struct device *dev, struct csio_hw *hw =
> > csio_lnode_to_hw(ln); 
> >  	if (csio_is_hw_ready(hw))
> > -		return snprintf(buf, PAGE_SIZE, "ready\n");
> > +		return sysfs_emit(buf, "ready\n");
> >  	else  
> 
> While at it, you could remove this useless else here.
> 
> > -		return snprintf(buf, PAGE_SIZE, "not ready\n");
> > +		return sysfs_emit(buf,  "not ready\n");  
> 
> Extra space after the ",".
Hi,
  OK, I see.

Thanks.
> 
> >  }
> >  
> >  /* Device reset */
> > @@ -1430,7 +1430,7 @@ csio_show_dbg_level(struct device *dev,
> >  {
> >  	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
> >  
> > -	return snprintf(buf, PAGE_SIZE, "%x\n",
> > ln->params.log_level);
> > +	return sysfs_emit(buf, "%x\n", ln->params.log_level);
> >  }
> >  
> >  /* Store debug level */
> > @@ -1476,7 +1476,7 @@ csio_show_num_reg_rnodes(struct device *dev,
> >  {
> >  	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
> >  
> > -	return snprintf(buf, PAGE_SIZE, "%d\n",
> > ln->num_reg_rnodes);
> > +	return sysfs_emit(buf, "%d\n", ln->num_reg_rnodes);
> >  }
> >  
> >  static DEVICE_ATTR(num_reg_rnodes, S_IRUGO,
> > csio_show_num_reg_rnodes, NULL);  
> 

