Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EB4FA2AD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiDIE2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbiDIE1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:27:47 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845412E1627;
        Fri,  8 Apr 2022 21:25:39 -0700 (PDT)
X-UUID: ba5dd6ec4e194e7e858000d3602be3bc-20220409
X-CPASD-INFO: dfdc728120ed4e33ae419e466acbcd6f@rbaeg2RkZmFeUKewg6h-bYGWZGFpkVS
        FeJuDkpGUYoaVhH5xTWVlZ15UfYBqVWVbZV9ZenRqUmFeaFxTi3akdmpQYIRkXW10qrWmnVdiZmE=
X-CLOUD-ID: dfdc728120ed4e33ae419e466acbcd6f
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:0.6,TVAL:179
        .0,ESV:0.0,ECOM:0.0,ML:0.0,FD:0.0,CUTS:110.0,IP:-2.0,MAL:-5.0,PHF:0.0,PHC:0.0
        ,SPF:4.0,EDMS:-5,IPLABEL:-2.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5,AU
        F:10,DUF:36647,ACD:248,DCD:350,SL:0,EISP:0,AG:0,CFC:0.324,CFSR:0.2,UAT:1,RAF:
        2,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF
        :0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: ba5dd6ec4e194e7e858000d3602be3bc-20220409
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: ba5dd6ec4e194e7e858000d3602be3bc-20220409
X-User: lienze@kylinos.cn
Received: from asus [(61.48.215.124)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1212242366; Sat, 09 Apr 2022 12:24:25 +0800
Date:   Sat, 9 Apr 2022 12:25:30 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     phil@philpotter.co.uk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: do not print info list when there is no cdrom
 device
Message-ID: <20220409122530.60353fcd@asus>
In-Reply-To: <25390602-cfa0-dba3-bfbc-a35ed6b44bcf@kernel.dk>
References: <20220408084221.1681592-1-lienze@kylinos.cn>
        <25390602-cfa0-dba3-bfbc-a35ed6b44bcf@kernel.dk>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 06:34:04 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 4/8/22 2:42 AM, Enze Li wrote:
> > There is no need to print a list of cdrom entries with blank info
> > when no cdrom device exists.  With this patch applied, we get:
> > 
> > ================================================
> > $ cat /proc/sys/dev/cdrom/info
> > CD-ROM information, Id:cdrom.c 3.20 2003/12/17
> > 
> > No device found.
> > 
> > ================================================  

Hi Jens,

Thanks for your review.

> 
> And what did we get before?

Without the patch, we get:

================================================
$ cat /proc/sys/dev/cdrom/info
CD-ROM information, Id: cdrom.c 3.20 2003/12/17

drive name:	
drive speed:	
drive # of slots:
Can close tray:	
Can open tray:	
Can lock tray:	
Can change speed:
Can select disk:
Can read multisession:
Can read MCN:	
Reports media changed:
Can play audio:	
Can write CD-R:	
Can write CD-RW:
Can read DVD:	
Can write DVD-R:
Can write DVD-RAM:
Can read MRW:	
Can write MRW:	
Can write RAM:	


================================================

> 
> Will this potentially break applications that parse it?
> 

I dunno, is there any way to confirm this thing?  And if this is really
a possibility, does it mean that we cannot make changes?

BTW, could you pls help review the following patch?  I forgot to cc you
and linux-block@list. :)
https://lore.kernel.org/lkml/20220406090337.1116708-1-lienze@kylinos.cn/

Thanks,
Enze
