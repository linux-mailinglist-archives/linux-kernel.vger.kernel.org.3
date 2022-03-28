Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD4B4E9B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiC1PwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbiC1PwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B10CD5;
        Mon, 28 Mar 2022 08:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F629613FB;
        Mon, 28 Mar 2022 15:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CC1C004DD;
        Mon, 28 Mar 2022 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648482638;
        bh=cfmzoeuc0V8BTCkvRfj2S2digY7zbrgxq081UFRKSiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/S6hrX0lFQCyAH8QUge1wrf1MquW+Br4gd7ulK2dCOB410WfDouWGyQV4rp7zO7V
         9guwMf+mZHGsCXtesW95MsOTt2ErcUQ4G9I5twWpOJIzggciko9EgW9BDedb5+TJbh
         9AkvZW8AzxWThc7mRbbuSf/O+ooz8awzqL7n//hW9D7Y2WKLJX8mRjn4WXQ1pdTSEI
         YbdtewqJkRavHBKy5Zyr3qXtrMttCyO4rB9ORUpc0ytauDDe3FrQh5bQ31oU93b3Zf
         uWVL9Ia0rOjxsnH1V9SIDkkJn6Q9chZ523TM+zOFsthJbZnSuv6dl6yDkrJia+9OCW
         Tq8qJQDzqCBaQ==
Date:   Mon, 28 Mar 2022 08:50:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, darcagn@protonmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
Message-ID: <YkHZRzbi54t0pZkO@thelio-3990X>
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com>
 <CAB95QASpZTz4eMger46WEa9xWJNmARShBUNb7edJA1eij3KBwA@mail.gmail.com>
 <a1607f0d-9d6c-fb55-d0d2-b57e4fdfda23@roeck-us.net>
 <CAB95QAQTtVWMs3dOx87G+D_GzGuMjnmPGiYQLqqQiCHT939Upw@mail.gmail.com>
 <a2a3ab35-7e21-51f9-fee2-67f6686b13c8@roeck-us.net>
 <CAB95QARqSm=TLsynwfoXUS2+rfi6ghUHekSoPv3JHn0GyaDTdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB95QARqSm=TLsynwfoXUS2+rfi6ghUHekSoPv3JHn0GyaDTdw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 04:44:24PM +0200, Eugene Shalygin wrote:
> > First, you can go up to 100 columns nowadays. Second, the column
> > limit is waived for strings because it is more important to not
> > split them. If you _still_ want to stick with 80 columns, sorry,
> > no, I don't have a solution. Your problem is with the editor,
> > not with kernel formatting rules.
> 
> Thank you, Günter, 100 is better than 80 and the string fits. I
> wonder, why is the .clang-format file not updated and still says the
> limit is 80?

Because the documentation still says that 80 is preferred:

https://kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings

"The preferred limit on the length of a single line is 80 columns.

Statements longer than 80 columns should be broken into sensible chunks,
unless exceeding 80 columns significantly increases readability and does
not hide information."

There have been a few different times that people have tried to update
the .clang-format file, which ultimately leads back to that paragraph in
the documentation.

https://lore.kernel.org/r/20200610125147.2782142-1-christian.brauner@ubuntu.com/
https://lore.kernel.org/r/03d462504887401ffbcdb58a392ad01923a2be7b.camel@perches.com/

A somewhat recent patch to try and update the documentation to match
checkpatch was posted but did not really go anywhere:

https://lore.kernel.org/r/d7130556-a8a4-76c0-0fde-b6b1439efda6@infradead.org/

Cheers,
Nathan
