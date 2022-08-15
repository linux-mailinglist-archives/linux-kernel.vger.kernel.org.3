Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65EF592A18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbiHOHHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiHOHHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:07:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E215FD4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:07:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t22so6258929pjy.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=d8dVTQ61h74//IiNS8ult/UyvToEoiQ8Qp1Jo3t+hKE=;
        b=n+XrueGckfBi/YbrvI1We9ylD/+cQzf/PVWo/CXMQKXRcqiToukZcz7L38gfFoS5XF
         zUKIBQMpQBIDD/65kuC3VTQJPgJXFteFJ7Sqvi39Kp7wslNgBEWd0MIVYimCyTRftjh/
         6pw1dtpOht7kXadpIsSxH9IA0AsAmcGA1Zyhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=d8dVTQ61h74//IiNS8ult/UyvToEoiQ8Qp1Jo3t+hKE=;
        b=qFFEijjTiqznlSe9DOOrjWWjad2s+XY/wpTnv8FhYNkJI8Lfvs/My3V30hLSCn6uen
         LTGO3XQQDhtOs2xZ+oXumcSexQZ/9AoRkVGRbJyjiKQlPixQQ3RBXezxp+8+1Q746IDv
         EJ/V43EcJmXRq8DCIOQCdq09EO2Z+5X8teyi+GmOklFk/CV7WHhIqEmHPWaBgjXzsH7f
         z0OwfmON8QLQdHaFApI0fkTJoKEGyxH9JWNmzhvxkuO8ShojPJctTCULODrei3ga+11S
         XB4XeKpratZp+hxzDvqJIO67pkOPVW2pLtkZuBm8NMzlAKi4aga2mdGVsQpEzoBsT3oY
         avkw==
X-Gm-Message-State: ACgBeo3lY7YYvkBdKe2/RrHs5qCPjYearTdKLO/+XAmzBzF/gaxeMan5
        Bum4qdmGdWwbPjjsr6GkVOK/ow==
X-Google-Smtp-Source: AA6agR5NcEcen1oGlvCJWVUf5Q4E5YysA7IctpK6zgem3+VFPdRBUqJebOyXYnLdlzFmWFGUpZb4uA==
X-Received: by 2002:a17:902:778b:b0:171:5bee:14a1 with SMTP id o11-20020a170902778b00b001715bee14a1mr13441250pll.153.1660547260563;
        Mon, 15 Aug 2022 00:07:40 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:110b:946c:84b2:7c95])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b0016edff78844sm6406957plh.277.2022.08.15.00.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:07:39 -0700 (PDT)
Date:   Mon, 15 Aug 2022 16:07:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvnwtN1SwQjilJ97@google.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
 <YvnrJBI8599+E43T@google.com>
 <YvnvnL9pBAgWMgTk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvnvnL9pBAgWMgTk@kroah.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/15 09:02), Greg KH wrote:
[..]
> > We haven't sent out KCAM for upstream review yet. It's open sourced,
> > as of this moment [1], but we still need some time and wanted to convert
> > one of the previous generations of IPU drivers (IPU3) to KCAM first to
> > see if everything is working as we wanted it to.
> 
> That didn't answer my question on when you were planning to actually
> submit this :)

Definitely not today. Someday, for sure :)

I don't want to promise any timelines. But we are certainly not
talking "weeks", we are talking "months". Several months is a
realistic timeline.
