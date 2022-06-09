Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC1B5454ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiFIT26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbiFIT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:28:32 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D890231CDA;
        Thu,  9 Jun 2022 12:28:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k24so6345980oij.2;
        Thu, 09 Jun 2022 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Wn8ou5dzmlGkBvt1t5T8F2i46s8eou6qGubG9EflRr8=;
        b=J1ObSlGrKviS0i68ZxexaDS6XvVYCx1gZ6GX064KKIsLykO2ZdahurMXEOQInYA3zq
         Pbgbl4neoAEferMSm02TZLrHYePgob2wKt5hCvrBv6BRMwqoEf1pMeXmQRapJpSe077c
         YU2F2YrH1R3+CmNVmSysST5zDRmmdZgnRxNpJx4FUO6JZliDgZVyc9V1UKTF6erAaDDa
         eVUVTOYyqEJ33EA+LXjQ4/XIrDSqgr+WCqmRq3zvLmoGiPj6qknbPkCDzaQC0Y/moemi
         vtS6q2vY9vwSbq+L79lyLNzCXwXIh1GXFXvNcQHmRH4ARM3ZbKQxfKLT7ZrRxn5fDNEz
         gI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Wn8ou5dzmlGkBvt1t5T8F2i46s8eou6qGubG9EflRr8=;
        b=j9uZ0+AtKPtBWli5J95ibbJ0LYGZoUrftaxBo0Q+IXXRTdg9emlGA4g8BoGgkDl5R9
         TnX4nB6m7VBNSQ9TSbO3l1gv9QAdY/DTk7yCMaPOmGDndrZnsKV5dJLvGjElGjs3SF9E
         lUuyhor5SU+C+/dbxjJMNMAXlXB5LORJJ0vYHGwPV+5q3qcx08kvj53G18Hs8fvplDbH
         yauc59JhpJxSWNMmukyWFf0/aFVsNNy/BCVTNPh7CtWQJC6bLJdge7GeR39qDj5JDy/R
         K0HwEcRudl4T3sRVubM6p6vfb5vrn67nQsEWwx3impmBDW9/owem59drGbocDVut/b3e
         +tVQ==
X-Gm-Message-State: AOAM531knimxqwYQKooMYb3qfwKDf3ZOa3Cy/rqpdaWWZcPPyWS7DL3D
        M6z6Mk16WhxHYVtZuCZlsSho82ZDT+Q=
X-Google-Smtp-Source: ABdhPJyLjio+oHIFUJQipnBSyuhTc9M3UIY4RzhicE2o482ywkFTzg+7+zFHppPs4Ga3HRwVVF72VA==
X-Received: by 2002:a05:6808:19a3:b0:32a:9f0b:81ab with SMTP id bj35-20020a05680819a300b0032a9f0b81abmr2664820oib.224.1654802909614;
        Thu, 09 Jun 2022 12:28:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x25-20020a9d4599000000b0060603221258sm12867042ote.40.2022.06.09.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:28:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Jun 2022 12:28:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Move device-specific data
 into struct aqc_data
Message-ID: <20220609192827.GA2167717@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 08:59:35PM +0200, Aleksa Savic wrote:
> As preparation for adding support for more devices in upcoming patches,
> move device-specific data, such as number of fans, temperature sensors,
> register offsets etc. to struct aqc_data. This is made possible by
> the fact that the supported Aquacomputer devices share the same layouts
> of sensor substructures. This allows aqc_raw_event() and others to stay
> general and not be cluttered with similar loops for each device.
> 

This is doing way more than that; it removes a lot of defines and
replaces them with constants, making it all but impossible to reliably
review the patch. That alone makes it unacceptable. On top of that,
I am not going to participate in a "thou shall use defines" vs.
"thou shall use raw constants" editing war. The driver uses defines
for constants. Keep using them.

Guenter
