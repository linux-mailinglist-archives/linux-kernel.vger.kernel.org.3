Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B15B2628
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiIHStj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiIHStf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:49:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D11AD98;
        Thu,  8 Sep 2022 11:49:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t70so11769561pgc.5;
        Thu, 08 Sep 2022 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=70evt0fga5cSU8vzI5IkYPmsc51xSTP7v5iFNVZKy7E=;
        b=iT0rQ2Tl9fn4nrL/OrajxzbiWk5tgwzjXr4e72wiKqg9UdAePQt3D50QUDoLnFqdmz
         0uFi0E1QJJVnkD/ClxVYDp+mrehFyozyVuZty1DrF6ZhKUlBgqPQeOcJBJzvLCIKVPBm
         F7dNZAfqiBl04zwdcTDT9uoCbjU2zgn/6uQQ9fQN+CQ+6USYGSPvGxJVuhuJNyShei1b
         x3ONNaPsmdMUFr+/RZsl1sOt0PbxvWhS3/zdi+nj3XjIP/0dMgp6UgG/ueSI309Ol1ZY
         AgL+5VMPpQmwdoW9b06Z44iUo9LSzxO2kbiiYo9HHU+hUAvVdXyYY9vWZYUQLAcBNOTw
         rLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=70evt0fga5cSU8vzI5IkYPmsc51xSTP7v5iFNVZKy7E=;
        b=CBYrs43+90g9uYPC+o0VMEUJkG7sX+UZowXABP7dvcR51JaqD0cdIphiEE8+9LZLfr
         zxpLqF+I4cWQIXrKRlKgKrSjpMV68jNzwO5UMBR7njSuHYJQa+/IvwHAXfkNhdvTpR5D
         CqH8vBtXJH6+kxAwTM5+S1pHYxPp/M1oKvqxXQSF78WCVwTMaEllqR0XoCbBp+SoQFkB
         DSprv7EvzN/gscnYvxSWgaJipUnlyOkMUEH/vZXIT+xkDkdfzb8tD41A88WA+SRPSG6o
         QJFvU6+4QpnjW/p5kmlbODUVFGjKgmfwf8QABPQuw8nV6o1HS41ZpEd3GVLLj2mNfz1n
         AcOA==
X-Gm-Message-State: ACgBeo0xWNtmRjOnDTHcLP0zVEX9HH/KSlFB+KG8IB1YiUc8TDEzbV3I
        Q8ZzTMnuhILX8REraBvNQPw=
X-Google-Smtp-Source: AA6agR4awBzcLuw8LW3O5IWod1zzZSn1VJ0mzzReIlVk8eLtY4N1dRYqKs/pt3uOlX8dqkdmMsKqww==
X-Received: by 2002:a63:286:0:b0:42b:3335:2b38 with SMTP id 128-20020a630286000000b0042b33352b38mr9064969pgc.414.1662662973968;
        Thu, 08 Sep 2022 11:49:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902c94f00b0016d295888e3sm888998pla.241.2022.09.08.11.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:49:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 11:49:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, jdelvare@suse.com, dev@aboehler.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] hwmon: (tps23861) reduce count of i2c
 transactions for port_status
Message-ID: <20220908184930.GA3173818@roeck-us.net>
References: <20220907015405.16547-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907015405.16547-1-mr.nuke.me@gmail.com>
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

On Tue, Sep 06, 2022 at 08:54:04PM -0500, Alexandru Gagniuc wrote:
> When reading the 'port_status' debugfs entry, some I2C registers were
> read more than once. This looks inefficient in an I2C trace.
> 
> To reduce I2C traffic, update tps23861_port_status_show() to only read
> each register once. Indexing the port number from 0 instead of 1 also
> allows simplifying things a bit.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
