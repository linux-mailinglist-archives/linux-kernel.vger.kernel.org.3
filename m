Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF147344C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbhLMSra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:47:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51452 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhLMSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:47:29 -0500
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id CE14220B7179;
        Mon, 13 Dec 2021 10:47:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE14220B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639421248;
        bh=dUD25ZM+98JlA4ZFOMpZK4r3WmNcHYNymIEsf9r5ZtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZ5VQGLP7cS39PF55HCHmPAIVwKHYH/VoG+2eU11cYac0IQSlb/9JMdvNXcJEqE8W
         sUdae56LJ6l5OByas+Ebe67+ePKxiTVsa605rATzQAhrRrUwkNN+Ncmi1bo4ZobcFK
         H5wcfjWx79TzmBbPNsrQTxIGiQMrr6NKyKHbR6Jg=
Date:   Mon, 13 Dec 2021 10:47:23 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 13/13] user_events: Use __get_rel_str for relative
 string fields
Message-ID: <20211213184723.GA10317@kbox>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
 <20211209223210.1818-14-beaub@linux.microsoft.com>
 <20211210102327.ab971d529613271ab1bf0073@kernel.org>
 <20211210184551.GB2242@kbox>
 <20211213001215.366afbe59715ed5aa1e2e865@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213001215.366afbe59715ed5aa1e2e865@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:12:15AM +0900, Masami Hiramatsu wrote:
> On Fri, 10 Dec 2021 10:45:51 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Fri, Dec 10, 2021 at 10:23:27AM +0900, Masami Hiramatsu wrote:
> > > Hi Beau,
> > > 
> > > On Thu,  9 Dec 2021 14:32:10 -0800
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > > 
> > > > Switch between __get_str and __get_rel_str within the print_fmt of
> > > > user_events. Add unit test to ensure print_fmt is correct on known
> > > > types.
> > > > 
> > > > Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> > > > ---
> > > >  kernel/trace/trace_events_user.c              |  24 ++-
> > > >  .../selftests/user_events/ftrace_test.c       | 166 ++++++++++++++++++
> > > >  2 files changed, 182 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > > > index 56eb58ddb4cf..3779fa2ca14a 100644
> > > > --- a/kernel/trace/trace_events_user.c
> > > > +++ b/kernel/trace/trace_events_user.c
> > > > @@ -257,7 +257,7 @@ static int user_event_add_field(struct user_event *user, const char *type,
> > > >  	goto add_field;
> > > >  
> > > >  add_validator:
> > > > -	if (strstr(type, "char[") != 0)
> > > > +	if (strstr(type, "char") != 0)
> > > >  		validator_flags |= VALIDATOR_ENSURE_NULL;
> > > 
> > > What is this change for? This seems not related to the other changes.
> > > (Also, what happen if it is a single char type?)
> > > 
> > 
> > I'm glad you asked, it appears like __data_loc / __rel_loc can take char
> > as it's type (It doesn't appear to be limited to char[] cases). I wanted
> > to ensure something malicious couldn't sneak past by using this corner
> > case.
> > 
> > IE: __data_loc char test
> > 
> > In trace_events_filter.c:
> > int filter_assign_type(const char *type)
> > {
> >         if (strstr(type, "__data_loc") && strstr(type, "char"))
> >                 return FILTER_DYN_STRING;
> > 
> >         if (strchr(type, '[') && strstr(type, "char"))
> >                 return FILTER_STATIC_STRING;
> > 
> >         if (strcmp(type, "char *") == 0 || strcmp(type, "const char *") == 0)
> >                 return FILTER_PTR_STRING;
> > 
> >         return FILTER_OTHER;
> > }
> > 
> > char[ is only checked if __data_loc is not specified.
> 
> OK, but in that case, is this patch good place for that change?
> 

I'll move this to part 12.

> > 
> > > >  
> > > >  	validator = kmalloc(sizeof(*validator), GFP_KERNEL);
> > > > @@ -456,14 +456,21 @@ static const char *user_field_format(const char *type)
> > > >  	return "%llu";
> > > >  }
> > > >  
> > > > -static bool user_field_is_dyn_string(const char *type)
> > > > +static bool user_field_is_dyn_string(const char *type, const char **str_func)
> > > >  {
> > > > -	if (str_has_prefix(type, "__data_loc ") ||
> > > > -	    str_has_prefix(type, "__rel_loc "))
> > > > -		if (strstr(type, "char[") != 0)
> > > > -			return true;
> > > > +	if (str_has_prefix(type, "__data_loc ")) {
> > > > +		*str_func = "__get_str";
> > > > +		goto check;
> > > > +	}
> > > > +
> > > > +	if (str_has_prefix(type, "__rel_loc ")) {
> > > > +		*str_func = "__get_rel_str";
> > > > +		goto check;
> > > > +	}
> > > >  
> > > >  	return false;
> > > > +check:
> > > > +	return strstr(type, "char") != 0;
> > > >  }
> > > >  
> > > >  #define LEN_OR_ZERO (len ? len - pos : 0)
> > > > @@ -472,6 +479,7 @@ static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
> > > >  	struct ftrace_event_field *field, *next;
> > > >  	struct list_head *head = &user->fields;
> > > >  	int pos = 0, depth = 0;
> > > > +	const char *str_func;
> > > >  
> > > >  	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
> > > >  
> > > > @@ -488,9 +496,9 @@ static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
> > > >  	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
> > > >  
> > > >  	list_for_each_entry_safe_reverse(field, next, head, link) {
> > > > -		if (user_field_is_dyn_string(field->type))
> > > > +		if (user_field_is_dyn_string(field->type, &str_func))
> > > >  			pos += snprintf(buf + pos, LEN_OR_ZERO,
> > > > -					", __get_str(%s)", field->name);
> > > > +					", %s(%s)", str_func, field->name);
> > > >  		else
> > > >  			pos += snprintf(buf + pos, LEN_OR_ZERO,
> > > >  					", REC->%s", field->name);
> > > > diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> > > 
> > > Just a nitpick, if possible, please split this part from the kernel update.
> > > 
> > 
> > I will try to do so, could you help me understand why I would split this
> > out? (For future patches)
> > 
> > I thought the intention of each would be to contain it's logical grouping:
> > I wanted to show, yes the code changed, and yes we have a unit test for
> > that new condition.
> 
> Hrm, in this specific case, maybe this can be acceptable. Following
> case you might need to take care of it.
> 
> - if the feature and the test code are maintained by different maintainer.
> - if the test code is added much later than the feature.
> 
> In both case, the piece of patches will be applied separately. The former
> case, by different maintainer, the latter case by different tree (e.g. 
> stable tree may not have the test case.)
> 
> BTW, I also think this change is a fix for the previous patches in the series.
> In that case, please update those patches so that the patch is completely works.
> That will be good for bisecting.
> 

Do you mean you want the rest of this change rolled into 04/13 (print_fmt
generation)?

And have the char vs char[ rolled into 12/13 (add validators)?

I can then roll the unit test for this case under 05/13 (ftrace
selftest).

Thanks,
-Beau

