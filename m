Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8754B5DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiFNQU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFNQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:20:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994AC1107
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:20:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t2so8161768pld.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UpDwJu4XSxI1BTGBncX03HHpQ6xslCySXDaRwYDm1sQ=;
        b=BnrxdQm8pIEnz64r6UjdrZZ3SyKW1IBbadkFm0L1eEDRA+BhFPYSneCfwb6P4N7O4K
         zHYJz1W2Y+a7uc/6WoGq/H1tJdUCJQ7I3SnVTmTGGdH/6uWrwPT8haJ9gqVa3NMShHHR
         N+KvJQ7EPlMQXnTJzKgdux0y1HVpRMhEB2jqg1oZQYn53J6w1Z+zMXz5bq1p36znXCM5
         FtmT4Lu47OpxPOU7B+Rq/nKgrE/nesiFzb9n1horoVZqQT8WuBWOUKf3bOzaNW0Qt2V/
         /WedXwwcFgrRqt8SW9iPpQ/boDlMr7qgBsHqNIAAJ6ehw8xWwReHvcbkm4oZwwoP4qkd
         bTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UpDwJu4XSxI1BTGBncX03HHpQ6xslCySXDaRwYDm1sQ=;
        b=M+phqMsWHUKPGj0dEJF8qL1lnG6keJHQH4wxVO6VyFORL7Zu8Ha/JWEFjBnlMFQ8mf
         cu2ATAg5FXqJyLzbUDAD20C8J8+1bw/5yDsyV+uDPM8aacKkPAGClTs8ksCxgT1vRNsa
         bYe7IHEfab76Gb8WDgkWGluRQuKq90o6IoBKFMLlo4s3I6Yl1ijR9MVfK0hujRE8XsOA
         xsCQOoDXan7osTtILjNoK8RUcaadsSCWfKoG4tF/UDhFFlnlrraEp4LlAZTnOnw9vCnO
         Za5u/sMflFxgb2HTAqqVF9uJSsfZAjbXVdVFoPTyBR8ltiw9mt7m6lS6H7khHZ5RgwyJ
         kjBA==
X-Gm-Message-State: AJIora94X9nSnz+4u/G5TQ3sUA4JqmubwGFuPJFSwyic0SdwXXPcO6qU
        YHsnahZMY03p/kqwoROUHSg=
X-Google-Smtp-Source: AGRyM1vhnd/FHCGfQ3R9YsXFWPUWnsumZGJVTp+B+8TD8lT2ZsRbI0BTt46FBAeCBLGTlrypwht9yQ==
X-Received: by 2002:a17:903:32d2:b0:166:3747:8461 with SMTP id i18-20020a17090332d200b0016637478461mr4999019plr.30.1655223623903;
        Tue, 14 Jun 2022 09:20:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:d337])
        by smtp.gmail.com with ESMTPSA id w9-20020a637b09000000b004085adf1372sm5059694pgc.77.2022.06.14.09.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:20:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Jun 2022 06:20:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <Yqi1RVRK2XahPWlg@slm.duckdns.org>
References: <20220614070346.810168-1-imran.f.khan@oracle.com>
 <20220614070346.810168-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614070346.810168-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:03:43PM +1000, Imran Khan wrote:
> +/**
> + * kernfs_deref_open_node_protected - Get kernfs_open_node corresponding to @kn
> + *
> + * @kn: target kernfs_node.
> + *
> + * Fetch and return ->attr.open of @kn when caller holds the
> + * kernfs_open_file_mutex.
> + *
> + * Update of ->attr.open happens under kernfs_open_file_mutex. So when
> + * the caller guarantees that this mutex is being held, other updaters can't
> + * change ->attr.open and this means that we can safely deref ->attr.open
> + * outside RCU read-side critical section.
> + *
> + * The caller needs to make sure that kernfs_open_file_mutex is held.
> + */
> +static struct kernfs_open_node *
> +kernfs_deref_open_node_protected(struct kernfs_node *kn)
> +{
> +	return rcu_dereference_check(kn->attr.open,
> +				lockdep_is_held(&kernfs_open_file_mutex));

Hey, so, the difference between rcu_dereference_check() and
rcu_dereference_protected() is that the former can be called either with rcu
read locked or under the extra condition (here, open_file_mutex held) while
the latter can't be used under rcu read lock. The two can generate different
codes too - the former enforces dependency ordering which makes accesses
under rcu read lock safe, while the latter doesn't.

In the above, you're saying that the accessor is only to be used while
holding kernfs_open_file_mutex but then using rcu_dereference_check() which
is odd. There are two ways you can go 1. ensure that the accessor is always
used under the mutex and use rcu_dereference_protected() or 2. if the
function can be used under rcu read lock, rename so that the differentiation
between the two accessors is based on the parameter type, not whether
they're protected or not.

Can you please post the updated patch as a reply to this one? No need to
post the whole thing over and over again.

Thanks.

-- 
tejun
